import '../models/knowledge_taxonomy.dart';
import '../models/user_profile.dart';

/// Nivel de dominio sobre una etiqueta del cerebro pedagógico.
enum MasteryLevel {
  sinDatos('Sin datos aún', 0),
  critico('Nivel Crítico', 1),
  enDesarrollo('Nivel En Desarrollo', 2),
  profesional('Nivel Profesional', 3),
  experto('Nivel Experto', 4);

  const MasteryLevel(this.label, this.rank);
  final String label;
  final int rank;

  bool get needsPractice =>
      this == MasteryLevel.critico ||
      this == MasteryLevel.sinDatos ||
      this == MasteryLevel.enDesarrollo;
}

/// Fila del Mapa de Maestría por etiquetas.
class TagMasteryRow {
  const TagMasteryRow({
    required this.code,
    required this.headline,
    required this.correct,
    required this.total,
    required this.accuracy,
    required this.level,
  });

  final KnowledgeCode code;
  final String headline;
  final int correct;
  final int total;
  final double accuracy;
  final MasteryLevel level;

  int get accuracyPercent => (accuracy * 100).round();

  String get subtitle {
    if (total == 0) {
      return 'Aún no practicas este dominio · forma parte de tu currículo';
    }
    return '$accuracyPercent% aciertos · $total evidencias';
  }
}

/// Calcula el mapa de maestría (competencias por norma/teoría, no conteo de ítems).
abstract final class TagMasteryService {
  /// Etiquetas del currículo que deben sentirse “completas” en el mapa.
  static const List<KnowledgeCode> curriculumCodes = [
    KnowledgeCode.decreto1290,
    KnowledgeCode.decreto1421,
    KnowledgeCode.ley1620,
    KnowledgeCode.guiaMen49,
    KnowledgeCode.guiaMen51,
    KnowledgeCode.decreto1278,
    KnowledgeCode.ley115,
    KnowledgeCode.decreto1860,
    KnowledgeCode.guiaMen50,
    KnowledgeCode.vygotsky,
    KnowledgeCode.ausubel,
    KnowledgeCode.piaget,
    KnowledgeCode.bruner,
    KnowledgeCode.ebc,
    KnowledgeCode.dba,
    KnowledgeCode.lineamientos,
  ];

  static String headlineFor(KnowledgeCode code) {
    switch (code) {
      case KnowledgeCode.decreto1290:
        return 'Decreto 1290 (Evaluación)';
      case KnowledgeCode.decreto1421:
        return 'Decreto 1421 (Inclusión / PIAR)';
      case KnowledgeCode.ley1620:
        return 'Ley 1620 (Convivencia)';
      case KnowledgeCode.guiaMen49:
        return 'Guía MEN 49 (Manual y rutas)';
      case KnowledgeCode.guiaMen51:
        return 'Guía MEN 51 (Atención)';
      case KnowledgeCode.decreto1278:
        return 'Decreto 1278 (Profesionalización)';
      case KnowledgeCode.ley115:
        return 'Ley 115 (PEI)';
      case KnowledgeCode.decreto1860:
        return 'Decreto 1860 (Gobierno escolar)';
      case KnowledgeCode.guiaMen50:
        return 'Guía MEN 50 (Educación inicial)';
      case KnowledgeCode.vygotsky:
        return 'Vygotsky (ZDP y andamiaje)';
      case KnowledgeCode.ausubel:
        return 'Ausubel (Aprendizaje significativo)';
      case KnowledgeCode.piaget:
        return 'Piaget (Desarrollo)';
      case KnowledgeCode.bruner:
        return 'Bruner (Representaciones)';
      case KnowledgeCode.ebc:
        return 'EBC (Competencias)';
      case KnowledgeCode.dba:
        return 'DBA (Aprendizajes por grado)';
      case KnowledgeCode.lineamientos:
        return 'Lineamientos curriculares';
    }
  }

  static MasteryLevel levelFor({required int total, required double accuracy}) {
    if (total == 0) return MasteryLevel.sinDatos;
    if (total < 3) {
      // Pocas evidencias: no declarar profesional aún.
      if (accuracy < 0.5) return MasteryLevel.critico;
      return MasteryLevel.enDesarrollo;
    }
    if (accuracy < 0.5) return MasteryLevel.critico;
    if (accuracy < 0.75) return MasteryLevel.enDesarrollo;
    if (accuracy < 0.9 || total < 8) return MasteryLevel.profesional;
    return MasteryLevel.experto;
  }

  static List<TagMasteryRow> buildMap(UserProfile profile) {
    final rows = <TagMasteryRow>[];
    for (final code in curriculumCodes) {
      final key = code.name;
      final total = profile.tagTotal[key] ?? 0;
      final correct = profile.tagCorrect[key] ?? 0;
      final accuracy = total == 0 ? 0.0 : correct / total;
      rows.add(
        TagMasteryRow(
          code: code,
          headline: headlineFor(code),
          correct: correct,
          total: total,
          accuracy: accuracy,
          level: levelFor(total: total, accuracy: accuracy),
        ),
      );
    }

    // Prioriza: crítico → sin datos → en desarrollo → resto (por % ascendente).
    rows.sort((a, b) {
      final rankA = _sortRank(a);
      final rankB = _sortRank(b);
      if (rankA != rankB) return rankA.compareTo(rankB);
      return a.accuracy.compareTo(b.accuracy);
    });
    return rows;
  }

  static int _sortRank(TagMasteryRow row) {
    switch (row.level) {
      case MasteryLevel.critico:
        return 0;
      case MasteryLevel.sinDatos:
        return 1;
      case MasteryLevel.enDesarrollo:
        return 2;
      case MasteryLevel.profesional:
        return 3;
      case MasteryLevel.experto:
        return 4;
    }
  }

  /// Etiqueta que más conviene practicar hoy.
  static TagMasteryRow? recommendedToday(UserProfile profile) {
    final map = buildMap(profile);
    for (final row in map) {
      if (row.level == MasteryLevel.critico) return row;
    }
    for (final row in map) {
      if (row.level == MasteryLevel.sinDatos) return row;
    }
    for (final row in map) {
      if (row.level == MasteryLevel.enDesarrollo) return row;
    }
    return map.isEmpty ? null : map.first;
  }

  static String recommendationMessage(UserProfile profile) {
    final row = recommendedToday(profile);
    if (row == null) {
      return 'Completa tu reto diario para activar el Mapa de Maestría.';
    }
    if (row.level == MasteryLevel.sinDatos) {
      return '${row.headline}: aún sin evidencias — te recomendamos practicar este dominio hoy.';
    }
    if (row.level == MasteryLevel.critico) {
      return '${row.headline}: ${row.level.label} '
          '(${row.accuracyPercent}% aciertos) — te recomendamos practicar este tema hoy.';
    }
    if (row.level == MasteryLevel.enDesarrollo) {
      return '${row.headline}: ${row.level.label} '
          '(${row.accuracyPercent}% aciertos) — un bloque enfocado hoy te acerca a Profesional.';
    }
    return 'Vas sólido en normas y teorías. Mantén el ritmo con un bloque mixto del cerebro pedagógico.';
  }

  /// Texto del paywall post-diagnóstico: solo etiquetas con evidencia real.
  static String diagnosticPaywallMessage(UserProfile profile) {
    final weak = buildMap(profile)
        .where(
          (row) =>
              row.total > 0 &&
              (row.level == MasteryLevel.critico ||
                  row.level == MasteryLevel.enDesarrollo),
        )
        .take(3)
        .toList();
    if (weak.isEmpty) {
      return 'Tu diagnóstico salió sólido en los dominios que alcanzamos a medir. '
          'Premium te deja simular sin tope y seguir subiendo el mapa.';
    }
    final names = weak.map((row) => row.headline).join(', ');
    return 'En tu diagnóstico el mapa muestra huecos reales en: $names. '
        'Premium abre práctica ilimitada y el simulacro cronometrado para corregirlos.';
  }
}
