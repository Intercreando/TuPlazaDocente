import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import '../models/question.dart';

/// Tope de caracteres del input (mismo contrato que la Function).
const int kMentorMaxUserChars = 250;

/// El servidor pidió el pase de 30 días (prueba usada o sesión de prueba cerrada).
class MentorPaywallException implements Exception {
  MentorPaywallException([
    this.message = 'Tu sesión de prueba ya se usó. Activa el pase de 30 días.',
  ]);

  final String message;

  @override
  String toString() => message;
}

/// Respuesta de un turno del Mentor IA.
class MentorTurnResult {
  const MentorTurnResult({
    required this.sessionId,
    required this.text,
    required this.turnCount,
    required this.turnsLeft,
    required this.status,
    this.closeReason,
    this.paywall = false,
    this.kind,
  });

  final String sessionId;
  final String text;
  final int turnCount;
  final int turnsLeft;
  final String status;
  final String? closeReason;
  final bool paywall;
  final String? kind;

  bool get closed => status == 'closed';
}

/// Cliente de startMentorSession / mentorConvoTurn. Candado anti doble clic.
class MentorConvoService {
  MentorConvoService({FirebaseFunctions? functions})
    : _functionsOverride = functions;

  final FirebaseFunctions? _functionsOverride;
  var _busy = false;

  bool get isBusy => _busy;

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

  Future<MentorTurnResult> start({
    required Question question,
    required int chosenIndex,
  }) async {
    if (chosenIndex < 0 || chosenIndex >= question.options.length) {
      throw Exception('La postura marcada no es válida.');
    }
    return _call('startMentorSession', <String, dynamic>{
      'questionId': question.id,
      'stem': question.stem,
      'caseContext': question.caseContext,
      'correctOption': question.options[question.correctIndex],
      'chosenOption': question.options[chosenIndex],
      'chosenIndex': chosenIndex,
      'correctIndex': question.correctIndex,
    });
  }

  Future<MentorTurnResult> turn({
    required String sessionId,
    required String text,
  }) async {
    final clipped = text.replaceAll(RegExp(r'\s+'), ' ').trim();
    if (clipped.length < 4) {
      throw Exception(
        'Escribe una respuesta corta sobre el caso (mínimo unas palabras).',
      );
    }
    return _call('mentorConvoTurn', <String, dynamic>{
      'sessionId': sessionId,
      'text': clipped,
    });
  }

  Future<MentorTurnResult> _call(
    String name,
    Map<String, dynamic> payload,
  ) async {
    if (_busy) {
      throw Exception(
        'El mentor está analizando tu postura. Espera un momento.',
      );
    }
    _busy = true;
    try {
      final callable = _functions.httpsCallable(
        name,
        options: HttpsCallableOptions(timeout: const Duration(seconds: 50)),
      );
      final result = await callable.call(payload);
      final raw = result.data;
      if (raw is! Map) {
        throw Exception('Respuesta inválida del mentor.');
      }
      final data = Map<String, dynamic>.from(raw);
      final text = (data['text'] as String?)?.trim() ?? '';
      if (text.length < 8) {
        throw Exception('El mentor no devolvió texto. Intenta de nuevo.');
      }
      return MentorTurnResult(
        sessionId: (data['sessionId'] as String?) ?? '',
        text: text,
        turnCount: (data['turnCount'] as num?)?.toInt() ?? 0,
        turnsLeft: (data['turnsLeft'] as num?)?.toInt() ?? 0,
        status: (data['status'] as String?) ?? 'active',
        closeReason: data['closeReason'] as String?,
        paywall: data['paywall'] == true,
        kind: data['kind'] as String?,
      );
    } on MentorPaywallException {
      rethrow;
    } on FirebaseFunctionsException catch (e) {
      debugPrint('MentorConvoService $name: ${e.code} ${e.message}');
      if (_isPaywall(e)) {
        throw MentorPaywallException(
          e.message ??
              'Tu sesión de prueba ya se usó. Activa el pase de 30 días.',
        );
      }
      throw Exception(_friendly(e));
    } catch (e) {
      debugPrint('MentorConvoService $name error: $e');
      if (e is Exception) rethrow;
      throw Exception(
        'No pudimos hablar con el mentor. Intenta de nuevo en un momento.',
      );
    } finally {
      _busy = false;
    }
  }

  bool _isPaywall(FirebaseFunctionsException e) {
    final details = e.details;
    if (details is Map && details['paywall'] == true) return true;
    return false;
  }

  String _friendly(FirebaseFunctionsException e) {
    switch (e.code) {
      case 'unauthenticated':
        return 'Inicia sesión (Google o correo) para hablar con el mentor.';
      case 'permission-denied':
        return e.message ?? 'El Mentor IA es un extra de Premium.';
      case 'resource-exhausted':
        return e.message ?? 'Ya usaste las tutorías del mentor por hoy.';
      case 'aborted':
        return e.message ??
            'El mentor está analizando tu postura. Espera un momento.';
      case 'unavailable':
        return e.message ??
            'El mentor no respondió. Intenta de nuevo en un momento.';
      default:
        return e.message ?? 'No pudimos continuar la tutoría.';
    }
  }
}
