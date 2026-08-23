import '../models/enums.dart';
import '../models/user_profile.dart';

/// Huecos entre el radar (4 pilares del examen) y el mapa de temas (normas/teoría).
///
/// El mapa de temas solo cubre pedagógico. Si nunca practicaste Numérica o
/// Lectura, el radar las deja al centro y Temas a reforzar debe ofrecerlas.
abstract final class ProgressGaps {
  static const cognitivePillars = [
    CompetencyPillar.aptitudNumerica,
    CompetencyPillar.lecturaCritica,
    CompetencyPillar.comportamental,
  ];

  /// Pilares del examen (no pedagógicos) sin ninguna evidencia.
  static List<CompetencyPillar> unmeasuredCognitive(UserProfile profile) {
    return [
      for (final pillar in cognitivePillars)
        if ((profile.pillarTotal[pillar.name] ?? 0) == 0) pillar,
    ];
  }

  /// El hueco del examen pesa más que un pilar ya medido.
  /// Si no hay evidencias en ningún pilar, el foco es pedagógico (50% CNSC).
  static CompetencyPillar weakestPillar(UserProfile profile) {
    final unmeasured = <CompetencyPillar>[];
    CompetencyPillar? weakestMeasured;
    var lowest = 2.0;

    for (final pillar in CompetencyPillar.values) {
      final total = profile.pillarTotal[pillar.name] ?? 0;
      if (total == 0) {
        unmeasured.add(pillar);
        continue;
      }
      final acc = profile.pillarAccuracy(pillar);
      if (acc < lowest) {
        lowest = acc;
        weakestMeasured = pillar;
      }
    }

    if (unmeasured.length == CompetencyPillar.values.length) {
      return CompetencyPillar.pedagogico;
    }
    if (unmeasured.contains(CompetencyPillar.pedagogico)) {
      return CompetencyPillar.pedagogico;
    }
    final cognitiveGaps = unmeasuredCognitive(profile);
    if (cognitiveGaps.isNotEmpty) return cognitiveGaps.first;
    return weakestMeasured ?? CompetencyPillar.pedagogico;
  }

  static String shortLabel(CompetencyPillar pillar) {
    switch (pillar) {
      case CompetencyPillar.aptitudNumerica:
        return 'Numérica';
      case CompetencyPillar.lecturaCritica:
        return 'Lectura';
      case CompetencyPillar.pedagogico:
        return 'Pedagógico';
      case CompetencyPillar.comportamental:
        return 'Comportamental';
    }
  }
}
