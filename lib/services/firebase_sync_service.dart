import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import '../models/user_profile.dart';

/// Auth anónima + sincronización de perfil en Firestore.
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

  Future<void> ensureSignedIn() async {
    try {
      final current = _auth.currentUser;
      if (current != null) {
        uid = current.uid;
        available = true;
        lastError = null;
        return;
      }
      final cred = await _auth.signInAnonymously();
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
      await _db.collection('users').doc(uid).set(
        {
          ...profile.toJson(),
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
}
