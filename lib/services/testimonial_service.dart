import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../data/seed_testimonials.dart';
import '../models/testimonial.dart';

/// Lectura pública de opiniones aprobadas + envío moderado vía Function.
class TestimonialService {
  TestimonialService({
    FirebaseFirestore? firestore,
    FirebaseFunctions? functions,
  })  : _dbOverride = firestore,
        _functionsOverride = functions;

  final FirebaseFirestore? _dbOverride;
  final FirebaseFunctions? _functionsOverride;

  FirebaseFirestore? get _db {
    if (_dbOverride != null) return _dbOverride;
    if (Firebase.apps.isEmpty) return null;
    return FirebaseFirestore.instance;
  }

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) {
      throw Exception('Firebase no está disponible.');
    }
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  /// Opiniones aprobadas; completa con seeds si aún hay pocas reales.
  Future<List<Testimonial>> loadApproved({int limit = 8}) async {
    final safeLimit = limit.clamp(1, 20);
    final fromCloud = <Testimonial>[];
    final db = _db;
    if (db != null) {
      try {
        final snap = await db
            .collection('testimonials')
            .where('approved', isEqualTo: true)
            .orderBy('createdAt', descending: true)
            .limit(safeLimit)
            .get();
        for (final doc in snap.docs) {
          final item = Testimonial.fromMap(doc.id, doc.data());
          if (item.text.isNotEmpty) fromCloud.add(item);
        }
      } catch (e) {
        debugPrint('TestimonialService loadApproved: $e');
      }
    }

    if (fromCloud.length >= 4) {
      return fromCloud.take(safeLimit).toList();
    }

    final merged = <Testimonial>[...fromCloud];
    final seen = merged.map((t) => t.text).toSet();
    for (final seed in SeedTestimonials.all) {
      if (merged.length >= safeLimit) break;
      if (seen.add(seed.text)) merged.add(seed);
    }
    return merged;
  }

  /// Envía opinión para moderación (no se publica al instante).
  Future<void> submit({
    required String text,
    required String displayName,
    String? roleLabel,
  }) async {
    final callable = _functions.httpsCallable(
      'submitTestimonial',
      options: HttpsCallableOptions(timeout: const Duration(seconds: 20)),
    );
    await callable.call(<String, dynamic>{
      'text': text.trim(),
      'displayName': displayName.trim(),
      if (roleLabel != null && roleLabel.trim().isNotEmpty)
        'roleLabel': roleLabel.trim(),
    });
  }
}
