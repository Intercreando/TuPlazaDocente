import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../data/reel_clip.dart';

/// Casos de reels creados desde el estudio. Solo el admin lee y escribe esta
/// colección (ver `firestore.rules`).
///
/// Se guardan en la nube, no en el navegador, porque la fuente de OBS abre la
/// URL en su propio navegador y también tiene que verlos.
class ReelClipService {
  ReelClipService({FirebaseFirestore? firestore})
    : _firestoreOverride = firestore;

  final FirebaseFirestore? _firestoreOverride;

  static const collection = 'reelClips';

  FirebaseFirestore? get _db {
    if (_firestoreOverride != null) return _firestoreOverride;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseFirestore.instance;
  }

  /// Casos guardados, del más reciente al más antiguo. Nunca lanza: si algo
  /// falla, el estudio sigue funcionando con los casos del código.
  Future<List<ReelClip>> list({int limit = 200}) async {
    final db = _db;
    if (db == null) return const [];
    try {
      final snap = await db.collection(collection).limit(limit).get();
      final entries = <({ReelClip clip, int order})>[];
      for (final doc in snap.docs) {
        final data = doc.data();
        final clip = ReelClip.fromMap(doc.id, data);
        if (clip == null) {
          debugPrint('ReelClipService: documento incompleto ${doc.id}');
          continue;
        }
        final order = data['updatedAtMs'];
        entries.add((clip: clip, order: order is int ? order : 0));
      }
      entries.sort((a, b) => b.order.compareTo(a.order));
      return entries.map((e) => e.clip).toList();
    } catch (e) {
      debugPrint('ReelClipService list: $e');
      return const [];
    }
  }

  /// Crea o actualiza un caso. Lanza con un mensaje legible si no se pudo.
  Future<void> save(ReelClip clip) async {
    final db = _db;
    if (db == null) {
      throw Exception('Firebase no está disponible en esta sesión.');
    }
    try {
      await db.collection(collection).doc(clip.id).set({
        ...clip.toMap(),
        'updatedAtMs': DateTime.now().millisecondsSinceEpoch,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    } catch (e) {
      debugPrint('ReelClipService save: $e');
      throw Exception(_friendly(e));
    }
  }

  Future<void> delete(String id) async {
    final db = _db;
    if (db == null) {
      throw Exception('Firebase no está disponible en esta sesión.');
    }
    try {
      await db.collection(collection).doc(id).delete();
    } catch (e) {
      debugPrint('ReelClipService delete: $e');
      throw Exception(_friendly(e));
    }
  }

  String _friendly(Object error) {
    final text = error.toString().toLowerCase();
    if (text.contains('permission-denied') || text.contains('permisos')) {
      return 'Firestore rechazó la escritura. Falta publicar las reglas '
          '(firebase deploy --only firestore:rules) o iniciar sesión como admin.';
    }
    if (text.contains('unavailable') || text.contains('network')) {
      return 'Sin conexión con Firestore. Revisa la red e inténtalo de nuevo.';
    }
    return 'No se pudo guardar el caso. Inténtalo de nuevo.';
  }
}
