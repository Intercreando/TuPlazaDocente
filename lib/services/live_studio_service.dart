import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../data/live_session.dart';

/// Sincroniza el panel del anfitrión con el lienzo que captura OBS.
///
/// El panel escribe; la fuente Navegador de OBS (sin sesión) solo lee.
/// Así puedes cambiar de caso en Chrome y el directo sigue en YouTube.
class LiveStudioService {
  LiveStudioService({FirebaseFirestore? firestore})
    : _firestoreOverride = firestore;

  final FirebaseFirestore? _firestoreOverride;

  static const docPath = 'liveStudio/current';

  FirebaseFirestore? get _db {
    if (_firestoreOverride != null) return _firestoreOverride;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseFirestore.instance;
  }

  Stream<LiveSession?> watch({String? fallbackId}) {
    final db = _db;
    if (db == null) return Stream.value(null);
    return db.doc(docPath).snapshots().map((snap) {
      final data = snap.data();
      if (data == null) return null;
      return LiveSession.fromMap(data, fallbackId: fallbackId);
    });
  }

  Future<void> publish(LiveSession session) async {
    final db = _db;
    if (db == null) {
      throw Exception('Firebase no está disponible en esta sesión.');
    }
    try {
      await db.doc(docPath).set({
        ...session.toMap(),
        'updatedAtMs': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('LiveStudioService publish: $e');
      throw Exception(_friendly(e));
    }
  }

  String _friendly(Object error) {
    final text = error.toString().toLowerCase();
    if (text.contains('permission-denied') || text.contains('permisos')) {
      return 'Firestore rechazó la escritura. Publica las reglas '
          '(firebase deploy --only firestore:rules) o entra como admin.';
    }
    if (text.contains('unavailable') || text.contains('network')) {
      return 'Sin conexión con Firestore. El lienzo de esta ventana sigue, '
          'pero OBS no se enterará del cambio.';
    }
    return 'No se pudo publicar el directo. Inténtalo de nuevo.';
  }
}
