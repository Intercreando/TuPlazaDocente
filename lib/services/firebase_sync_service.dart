import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';

/// Auth (anónimo / email / Google) + sincronización de perfil en Firestore.
class FirebaseSyncService {
  FirebaseSyncService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _auth = auth ?? FirebaseAuth.instance,
        _db = firestore ?? FirebaseFirestore.instance;

  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  bool available = false;
  String? uid;
  String? lastError;

  User? get currentUser => _auth.currentUser;
  bool get isAnonymous => currentUser?.isAnonymous ?? true;
  String? get email => currentUser?.email;
  String? get displayName => currentUser?.displayName;

  Future<void> ensureSignedIn() async {
    try {
      final current = _auth.currentUser;
      if (current != null) {
        uid = current.uid;
        available = true;
        lastError = null;
        return;
      }
      final cred = await _auth.signInAnonymously().timeout(
        const Duration(seconds: 6),
      );
      uid = cred.user?.uid;
      available = uid != null;
      lastError = null;
    } catch (e) {
      available = false;
      uid = null;
      lastError =
          'No pudimos sincronizar en la nube. Seguirás con progreso local.';
      debugPrint('FirebaseSync ensureSignedIn: $e');
    }
  }

  Future<bool> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      uid = cred.user?.uid;
      available = uid != null;
      lastError = null;
      return true;
    } on FirebaseAuthException catch (e) {
      lastError = _mapAuthError(e);
      return false;
    } catch (e) {
      lastError = 'No se pudo iniciar sesión. Intenta de nuevo.';
      debugPrint('signInWithEmail: $e');
      return false;
    }
  }

  Future<bool> registerWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final current = _auth.currentUser;
      if (current != null && current.isAnonymous) {
        final credential = EmailAuthProvider.credential(
          email: email.trim(),
          password: password,
        );
        final linked = await current.linkWithCredential(credential);
        uid = linked.user?.uid;
      } else {
        final cred = await _auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
        uid = cred.user?.uid;
      }
      available = uid != null;
      lastError = null;
      return true;
    } on FirebaseAuthException catch (e) {
      // Si el email ya existe, intenta login directo.
      if (e.code == 'email-already-in-use') {
        return signInWithEmail(email: email, password: password);
      }
      lastError = _mapAuthError(e);
      return false;
    } catch (e) {
      lastError = 'No se pudo crear la cuenta. Intenta de nuevo.';
      debugPrint('registerWithEmail: $e');
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      final provider = GoogleAuthProvider()..addScope('email');
      // Solo pedimos selector en el primer intento (cuenta cerrada / cambiar cuenta).
      provider.setCustomParameters({'prompt': 'select_account'});

      final current = _auth.currentUser;
      late UserCredential cred;

      if (kIsWeb) {
        if (current != null && current.isAnonymous) {
          try {
            // Nuevo Google: conserva el UID anónimo y su progreso en Firestore.
            cred = await current.linkWithPopup(provider);
          } on FirebaseAuthException catch (e) {
            if (_isExistingGoogleAccountConflict(e)) {
              // Cuenta Google ya registrada: NO abrir otro selector.
              // Reutiliza la credencial del primer popup (o un popup silencioso).
              cred = await _signInExistingGoogleWithoutReprompt(e);
            } else {
              rethrow;
            }
          }
        } else {
          cred = await _auth.signInWithPopup(provider);
        }
      } else {
        cred = await _auth.signInWithProvider(provider);
      }

      uid = cred.user?.uid;
      available = uid != null;
      lastError = null;
      return true;
    } on FirebaseAuthException catch (e) {
      lastError = _mapAuthError(e);
      return false;
    } catch (e) {
      lastError =
          'Google Sign-In no disponible aún. Actívalo en Firebase Authentication.';
      debugPrint('signInWithGoogle: $e');
      return false;
    }
  }

  bool _isExistingGoogleAccountConflict(FirebaseAuthException e) {
    return e.code == 'credential-already-in-use' ||
        e.code == 'email-already-in-use' ||
        e.code == 'account-exists-with-different-credential';
  }

  /// Tras un link fallido porque la cuenta ya existe: entra sin volver a listar cuentas.
  Future<UserCredential> _signInExistingGoogleWithoutReprompt(
    FirebaseAuthException linkError,
  ) async {
    final pending = linkError.credential;
    if (pending != null) {
      try {
        return await _auth.signInWithCredential(pending);
      } catch (e) {
        debugPrint('signInWithCredential tras link: $e');
      }
    }

    // Fallback: el navegador ya tiene la sesión Google del primer intento.
    // Sin prompt=select_account suele completar solo, sin segunda lista.
    final silent = GoogleAuthProvider()..addScope('email');
    return _auth.signInWithPopup(silent);
  }

  Future<bool> signOutToAnonymous() async {
    try {
      lastError = null;
      await _auth.signOut();
      uid = null;
      available = false;
      await ensureSignedIn();
      if (!available) {
        lastError ??= 'No se pudo abrir una sesión de invitado.';
        return false;
      }
      return true;
    } catch (e) {
      lastError = 'No se pudo cerrar sesión.';
      debugPrint('signOutToAnonymous: $e');
      return false;
    }
  }

  Future<UserProfile?> loadRemoteProfile() async {
    if (!available || uid == null) return null;
    try {
      final snap = await _db.collection('users').doc(uid).get();
      if (!snap.exists || snap.data() == null) return null;
      return UserProfile.fromJson(snap.data()!);
    } catch (e) {
      lastError = 'No se pudo leer tu progreso en la nube.';
      debugPrint('FirebaseSync loadRemoteProfile: $e');
      return null;
    }
  }

  Future<void> saveRemoteProfile(UserProfile profile) async {
    if (!available || uid == null) return;
    try {
      // isPremium solo lo escribe el backend (Mercado Pago / códigos).
      final data = Map<String, dynamic>.from(profile.toJson())
        ..remove('isPremium');
      await _db.collection('users').doc(uid).set(
        {
          ...data,
          'email': email,
          'authProvider': isAnonymous ? 'anonymous' : 'registered',
          'updatedAt': FieldValue.serverTimestamp(),
        },
        SetOptions(merge: true),
      );
      lastError = null;
    } catch (e) {
      lastError = 'No se pudo guardar en la nube. El progreso local sí quedó.';
      debugPrint('FirebaseSync saveRemoteProfile: $e');
    }
  }

  String _mapAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'El correo no es válido.';
      case 'user-disabled':
        return 'Esta cuenta está deshabilitada.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'weak-password':
        return 'La contraseña debe tener al menos 6 caracteres.';
      case 'email-already-in-use':
        return 'Ese correo ya está registrado. Inicia sesión.';
      case 'popup-closed-by-user':
        return 'Cerraste la ventana de Google antes de terminar.';
      case 'operation-not-allowed':
        return 'Este método de acceso no está habilitado en Firebase.';
      default:
        return e.message ?? 'Error de autenticación (${e.code}).';
    }
  }
}
