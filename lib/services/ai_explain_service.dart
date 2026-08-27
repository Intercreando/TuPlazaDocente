import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/question.dart';

/// Respuesta del tutor de texto (Gemini vía Cloud Function).
class AiExplainResult {
  const AiExplainResult({
    required this.text,
    required this.remaining,
    this.cached = false,
  });

  final String text;
  final int remaining;
  final bool cached;
}

/// Cliente del explicador Premium (8 ampliaciones / día).
class AiExplainService {
  AiExplainService({FirebaseFunctions? functions})
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

  /// Pide una ampliación para un ítem fallado.
  Future<AiExplainResult> explainWrongChoice({
    required Question question,
    required int chosenIndex,
  }) async {
    if (chosenIndex < 0 || chosenIndex >= question.options.length) {
      throw Exception('La opción marcada no es válida.');
    }
    if (chosenIndex == question.correctIndex) {
      throw Exception(
        'La ampliación es para cuando la opción marcada no es la mejor.',
      );
    }
    try {
      final callable = _functions.httpsCallable(
        'explainPracticeItem',
        options: HttpsCallableOptions(timeout: const Duration(seconds: 45)),
      );
      final result = await callable.call(<String, dynamic>{
        'questionId': question.id,
        'stem': question.stem,
        'caseContext': question.caseContext,
        'correctOption': question.options[question.correctIndex],
        'chosenOption': question.options[chosenIndex],
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
      return AiExplainResult(
        text: text,
        remaining: (data['remaining'] as num?)?.toInt() ?? 0,
        cached: data['cached'] == true,
      );
    } on FirebaseFunctionsException catch (e) {
      debugPrint('AiExplainService: ${e.code} ${e.message}');
      throw Exception(_friendly(e));
    } catch (e) {
      debugPrint('AiExplainService error: $e');
      if (e is Exception) rethrow;
      throw Exception(
        'No pudimos ampliar la explicación. Verifica tu conexión.',
      );
    }
  }

  String _friendly(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return 'Inicia sesión (Google o correo) para usar el tutor.';
      case 'permission-denied':
        return e.message ?? 'El tutor está disponible en Premium.';
      case 'resource-exhausted':
        return e.message ?? 'Ya usaste las 8 ampliaciones de hoy.';
      case 'failed-precondition':
        return e.message ?? 'No se puede ampliar este ítem.';
      case 'invalid-argument':
        return e.message ?? 'Faltan datos del ítem.';
      case 'unavailable':
        return e.message ??
            'El tutor no respondió. Intenta de nuevo en un momento.';
      default:
        return e.message ?? 'No pudimos ampliar la explicación.';
    }
  }
}
