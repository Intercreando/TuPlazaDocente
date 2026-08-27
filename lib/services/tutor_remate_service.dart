import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/question.dart';

/// Chip de seguimiento del remate (Vertex, 2 al día).
enum TutorRemateChip {
  rector('rector', '¿Y si el rector insiste?'),
  norma('norma', '¿Qué exige la norma aquí?');

  const TutorRemateChip(this.id, this.label);
  final String id;
  final String label;
}

/// Cliente del remate conversacional (máximo 2 llamadas Vertex / día).
class TutorRemateService {
  TutorRemateService({FirebaseFunctions? functions})
    : _functionsOverride = functions;

  final FirebaseFunctions? _functionsOverride;

  FirebaseFunctions get _functions {
    final override = _functionsOverride;
    if (override != null) return override;
    if (Firebase.apps.isEmpty) {
      throw Exception(
        'Firebase no está disponible. Recarga la página e intenta de nuevo.',
      );
    }
    return FirebaseFunctions.instanceFor(region: 'southamerica-east1');
  }

  Future<String> remate({
    required Question question,
    required int chosenIndex,
    required TutorRemateChip chip,
  }) async {
    if (chosenIndex < 0 || chosenIndex >= question.options.length) {
      throw Exception('La postura marcada no es válida.');
    }
    try {
      final callable = _functions.httpsCallable(
        'tutorConvoRemate',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 45)),
      );
      final result = await callable.call(<String, dynamic>{
        'questionId': question.id,
        'stem': question.stem,
        'caseContext': question.caseContext,
        'correctOption': question.options[question.correctIndex],
        'chosenOption': question.options[chosenIndex],
        'chipId': chip.id,
      });
      final raw = result.data;
      if (raw is! Map) {
        throw Exception('Respuesta inválida del tutor.');
      }
      final data = Map<String, dynamic>.from(raw);
      final text = (data['text'] as String?)?.trim() ?? '';
      if (text.length < 8) {
        throw Exception('El tutor no devolvió texto. Intenta de nuevo.');
      }
      return text;
    } on FirebaseFunctionsException catch (e) {
      debugPrint('TutorRemateService: ${e.code} ${e.message}');
      throw Exception(_friendly(e));
    } catch (e) {
      debugPrint('TutorRemateService error: $e');
      if (e is Exception) rethrow;
      throw Exception(
        'No pudimos completar el remate. La sesión del caso sigue disponible.',
      );
    }
  }

  String _friendly(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return 'Inicia sesión (Google o correo) para el remate con tutor.';
      case 'permission-denied':
        return e.message ?? 'El remate del tutor es Premium.';
      case 'resource-exhausted':
        return e.message ?? 'Ya usaste los 2 remates de hoy.';
      case 'unavailable':
        return e.message ??
            'El remate no respondió. El contraste del caso sigue arriba.';
      default:
        return e.message ??
            'No pudimos generar el remate. El caso y el contraste no se pierden.';
    }
  }
}
