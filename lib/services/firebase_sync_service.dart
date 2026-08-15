import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';

/// Auth (anónimo / email / Google) + sincronización de perfil en Firestore.
class FirebaseSyncService {
  FirebaseSyncService({
    FirebaseAuth? auth,
    FirebaseFirestore? firestore,
  })  : _authOverride = auth,
        _dbOverride = firestore;

  final FirebaseAuth? _authOverride;
  final FirebaseFirestore? _dbOverride;

  bool available = false;
  String? uid;
  String? lastError;

  /// True solo cuando el último auth exitoso creó/vinculó cuenta nueva (no login).
  bool lastAuthWasRegistration = false;

  /// Descuento pendiente leído de Firestore (solo servidor lo escribe).
  int? pendingDiscountPercent;
  String? pendingDiscountCode;

  bool get _firebaseReady => Firebase.apps.isNotEmpty;

  FirebaseAuth? get _auth {
    if (_authOverride != null) return _authOverride;
    if (!_firebaseReady) return null;
    return FirebaseAuth.instance;
  }

  FirebaseFirestore? get _db {
    if (_dbOverride != null) return _dbOverride;
    if (!_firebaseReady) return null;
    return FirebaseFirestore.instance;
  }

  User? get currentUser => _auth?.currentUser;
  bool get isAnonymous => currentUser?.isAnonymous ?? true;
  String? get email => currentUser?.email;
  String? get displayName => currentUser?.displayName;

  Future<void> ensureSignedIn() async {
    final auth = _auth;
    if (auth == null) {
      available = false;
      lastError = 'Modo local: Firebase no está disponible en este momento.';
      return;
    }
    try {
      final current = auth.currentUser;
      if (current != null) {
        uid = current.uid;
        available = true;
        lastError = null;
        return;
      }
      final cred = await auth.signInAnonymously().timeout(
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
    final auth = _auth;
    if (auth == null) {
      lastError = 'Firebase no está disponible. Recarga e intenta de nuevo.';
      return false;
    }
    try {
      final cred = await auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      uid = cred.user?.uid;
      available = uid != null;
      lastAuthWasRegistration = false;
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

  /// Envía el correo de restablecimiento de Firebase Auth (enlace oficial).
  Future<bool> sendPasswordReset({required String email}) async {
    final auth = _auth;
    if (auth == null) {
      lastError = 'Firebase no está disponible. Recarga e intenta de nuevo.';
      return false;
    }
    final trimmed = email.trim();
    if (!trimmed.contains('@')) {
      lastError = 'Escribe un correo válido para enviarte el enlace.';
      return false;
    }
    try {
      await auth.sendPasswordResetEmail(
        email: trimmed,
        actionCodeSettings: ActionCodeSettings(
          url: 'https://www.tuplazadocente.com/auth',
          handleCodeInApp: false,
        ),
      );
      lastError = null;
      return true;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'invalid-email') {
        // No revelar si el correo existe; el usuario igual ve el mensaje genérico.
        lastError = null;
        return true;
      }
      lastError = _mapAuthError(e);
      return false;
    } catch (e) {
      lastError = 'No se pudo enviar el correo. Intenta de nuevo en un momento.';
      debugPrint('sendPasswordReset: $e');
      return false;
    }
  }

  Future<bool> registerWithEmail({
    required String email,
    required String password,
  }) async {
    final auth = _auth;
    if (auth == null) {
      lastError = 'Firebase no está disponible. Recarga e intenta de nuevo.';
      return false;
    }
    try {
      final current = auth.currentUser;
      if (current != null && current.isAnonymous) {
        final credential = EmailAuthProvider.credential(
          email: email.trim(),
          password: password,
        );
        final linked = await current.linkWithCredential(credential);
        uid = linked.user?.uid;
        lastAuthWasRegistration = true;
      } else {
        final cred = await auth.createUserWithEmailAndPassword(
          email: email.trim(),
          password: password,
        );
        uid = cred.user?.uid;
        lastAuthWasRegistration = true;
      }
      available = uid != null;
      lastError = null;
      return true;
    } on FirebaseAuthException catch (e) {
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
    final auth = _auth;
    if (auth == null) {
      lastError = 'Firebase no está disponible. Recarga e intenta de nuevo.';
      return false;
    }
    try {
      final provider = GoogleAuthProvider()..addScope('email');
      provider.setCustomParameters({'prompt': 'select_account'});

      final current = auth.currentUser;
      late UserCredential cred;
      var wasRegistration = false;

      if (kIsWeb) {
        if (current != null && current.isAnonymous) {
          try {
            cred = await current.linkWithPopup(provider);
            wasRegistration = true;
          } on FirebaseAuthException catch (e) {
            if (_isExistingGoogleAccountConflict(e)) {
              cred = await _signInExistingGoogleWithoutReprompt(auth, e);
              wasRegistration = false;
            } else {
              rethrow;
            }
          }
        } else {
          cred = await auth.signInWithPopup(provider);
          wasRegistration = cred.additionalUserInfo?.isNewUser ?? false;
        }
      } else {
        cred = await auth.signInWithProvider(provider);
        wasRegistration = cred.additionalUserInfo?.isNewUser ?? false;
      }

      uid = cred.user?.uid;
      available = uid != null;
      lastAuthWasRegistration = wasRegistration;
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

  Future<UserCredential> _signInExistingGoogleWithoutReprompt(
    FirebaseAuth auth,
    FirebaseAuthException linkError,
  ) async {
    final pending = linkError.credential;
    if (pending != null) {
      try {
        return await auth.signInWithCredential(pending);
      } catch (e) {
        debugPrint('signInWithCredential tras link: $e');
      }
    }

    final silent = GoogleAuthProvider()..addScope('email');
    return auth.signInWithPopup(silent);
  }

  Future<bool> signOutToAnonymous() async {
    final auth = _auth;
    if (auth == null) {
      lastError = 'Firebase no está disponible.';
      return false;
    }
    try {
      lastError = null;
      await auth.signOut();
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
    final db = _db;
    if (!available || uid == null || db == null) return null;
    try {
      final snap = await db.collection('users').doc(uid).get();
      if (!snap.exists || snap.data() == null) return null;
      final data = snap.data()!;
      final pending = data['pendingPromoDiscount'];
      if (pending is Map) {
        pendingDiscountPercent = (pending['percent'] as num?)?.toInt();
        pendingDiscountCode = pending['code']?.toString();
      } else {
        pendingDiscountPercent = null;
        pendingDiscountCode = null;
      }
      return UserProfile.fromJson(data);
    } catch (e) {
      lastError = 'No se pudo leer tu progreso en la nube.';
      debugPrint('FirebaseSync loadRemoteProfile: $e');
      return null;
    }
  }

  Future<void> saveRemoteProfile(UserProfile profile) async {
    final db = _db;
    if (!available || uid == null || db == null) return;
    try {
      final data = Map<String, dynamic>.from(profile.toJson())
        ..remove('isPremium')
        // Solo el servidor escribe cohorte de pauta y caducidad de oferta.
        ..remove('acquiredViaPaid')
        ..remove('welcomeOfferExpiresAt');
      await db.collection('users').doc(uid).set(
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
      case 'too-many-requests':
        return 'Demasiados intentos. Espera unos minutos e inténtalo de nuevo.';
      case 'operation-not-allowed':
        return 'Este método de acceso no está habilitado en Firebase.';
      default:
        return e.message ?? 'Error de autenticación (${e.code}).';
    }
  }
}
