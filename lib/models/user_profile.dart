import '../utils/tmo_stats.dart';
import 'enums.dart';
import 'recent_session_snapshot.dart';

/// Perfil del aspirante y progreso persistente.
class UserProfile {
  const UserProfile({
    this.displayName = '',
    this.cargo,
    this.especialidad,
    this.onboardingComplete = false,
    this.isPremium = false,
    this.darkMode = false,
    this.streakDays = 0,
    this.lastStreakDate,
    this.dailyCompletedToday = false,
    this.examDate,
    this.topicMastery = const {},
    this.pillarCorrect = const {},
    this.pillarTotal = const {},
    this.tagCorrect = const {},
    this.tagTotal = const {},
    this.pillarTimeSpent = const {},
    this.tagTimeSpent = const {},
    this.pillarTimedCount = const {},
    this.tagTimedCount = const {},
    this.completedPlanTaskIds = const [],
    this.planTaskDate,
    this.streakRemindersEnabled = false,
    this.acquiredViaPaid = false,
    this.welcomeOfferExpiresAt,
    this.diagnosticCompleted = false,
    this.recentSessions = const [],
  });

  final String displayName;
  final CargoAspiracion? cargo;
  final Especialidad? especialidad;
  final bool onboardingComplete;
  final bool isPremium;
  final bool darkMode;
  final int streakDays;
  final DateTime? lastStreakDate;
  final bool dailyCompletedToday;
  final DateTime? examDate;
  final Map<String, double> topicMastery;
  final Map<String, int> pillarCorrect;
  final Map<String, int> pillarTotal;

  /// Aciertos por [KnowledgeCode.name] (Mapa de Maestría).
  final Map<String, int> tagCorrect;

  /// Intentos por [KnowledgeCode.name] (Mapa de Maestría).
  final Map<String, int> tagTotal;

  /// Segundos acumulados por [CompetencyPillar.name] (TMO histórico).
  final Map<String, int> pillarTimeSpent;

  /// Segundos acumulados por [KnowledgeCode.name] (TMO histórico).
  final Map<String, int> tagTimeSpent;

  /// Preguntas con cronómetro por pilar. No es [pillarTotal]: ese incluye
  /// respuestas anteriores a medir el tiempo.
  final Map<String, int> pillarTimedCount;

  /// Preguntas con cronómetro por etiqueta.
  final Map<String, int> tagTimedCount;

  final List<String> completedPlanTaskIds;
  final DateTime? planTaskDate;
  final bool streakRemindersEnabled;

  /// True si el registro vino de campaña (lo escribe el servidor).
  final bool acquiredViaPaid;

  /// Caducidad real de la oferta $69.900 (servidor, no se reinicia).
  final DateTime? welcomeOfferExpiresAt;

  /// Completó el diagnóstico inicial (pauta: obligatorio).
  final bool diagnosticCompleted;

  /// Últimas prácticas/simulacros (tope 5). Sirve al Tutor Inteligente.
  final List<RecentSessionSnapshot> recentSessions;

  int get totalAnswers =>
      pillarTotal.values.fold<int>(0, (sum, value) => sum + value);

  UserProfile copyWith({
    String? displayName,
    CargoAspiracion? cargo,
    Especialidad? especialidad,
    bool? onboardingComplete,
    bool? isPremium,
    bool? darkMode,
    int? streakDays,
    DateTime? lastStreakDate,
    bool? dailyCompletedToday,
    DateTime? examDate,
    Map<String, double>? topicMastery,
    Map<String, int>? pillarCorrect,
    Map<String, int>? pillarTotal,
    Map<String, int>? tagCorrect,
    Map<String, int>? tagTotal,
    Map<String, int>? pillarTimeSpent,
    Map<String, int>? tagTimeSpent,
    Map<String, int>? pillarTimedCount,
    Map<String, int>? tagTimedCount,
    List<String>? completedPlanTaskIds,
    DateTime? planTaskDate,
    bool? streakRemindersEnabled,
    bool? acquiredViaPaid,
    DateTime? welcomeOfferExpiresAt,
    bool? diagnosticCompleted,
    List<RecentSessionSnapshot>? recentSessions,
  }) {
    return UserProfile(
      displayName: displayName ?? this.displayName,
      cargo: cargo ?? this.cargo,
      especialidad: especialidad ?? this.especialidad,
      onboardingComplete: onboardingComplete ?? this.onboardingComplete,
      isPremium: isPremium ?? this.isPremium,
      darkMode: darkMode ?? this.darkMode,
      streakDays: streakDays ?? this.streakDays,
      lastStreakDate: lastStreakDate ?? this.lastStreakDate,
      dailyCompletedToday: dailyCompletedToday ?? this.dailyCompletedToday,
      examDate: examDate ?? this.examDate,
      topicMastery: topicMastery ?? this.topicMastery,
      pillarCorrect: pillarCorrect ?? this.pillarCorrect,
      pillarTotal: pillarTotal ?? this.pillarTotal,
      tagCorrect: tagCorrect ?? this.tagCorrect,
      tagTotal: tagTotal ?? this.tagTotal,
      pillarTimeSpent: pillarTimeSpent ?? this.pillarTimeSpent,
      tagTimeSpent: tagTimeSpent ?? this.tagTimeSpent,
      pillarTimedCount: pillarTimedCount ?? this.pillarTimedCount,
      tagTimedCount: tagTimedCount ?? this.tagTimedCount,
      completedPlanTaskIds: completedPlanTaskIds ?? this.completedPlanTaskIds,
      planTaskDate: planTaskDate ?? this.planTaskDate,
      streakRemindersEnabled:
          streakRemindersEnabled ?? this.streakRemindersEnabled,
      acquiredViaPaid: acquiredViaPaid ?? this.acquiredViaPaid,
      welcomeOfferExpiresAt:
          welcomeOfferExpiresAt ?? this.welcomeOfferExpiresAt,
      diagnosticCompleted: diagnosticCompleted ?? this.diagnosticCompleted,
      recentSessions: recentSessions ?? this.recentSessions,
    );
  }

  double pillarAccuracy(CompetencyPillar pillar) {
    final total = pillarTotal[pillar.name] ?? 0;
    if (total == 0) return 0;
    final correct = pillarCorrect[pillar.name] ?? 0;
    return correct / total;
  }

  double tagAccuracy(String knowledgeCodeName) {
    final total = tagTotal[knowledgeCodeName] ?? 0;
    if (total == 0) return 0;
    final correct = tagCorrect[knowledgeCodeName] ?? 0;
    return correct / total;
  }

  /// Segundos medios por pregunta con cronómetro. `null` si aún no hay ritmo.
  double? pillarTmo(CompetencyPillar pillar) {
    return TmoStats.averageSeconds(
      timeSpent: pillarTimeSpent[pillar.name] ?? 0,
      timedCount: pillarTimedCount[pillar.name] ?? 0,
    );
  }

  String get weakestPillarLabel {
    CompetencyPillar? weakest;
    var lowest = 2.0;
    for (final pillar in CompetencyPillar.values) {
      final acc = pillarAccuracy(pillar);
      final total = pillarTotal[pillar.name] ?? 0;
      if (total == 0) continue;
      if (acc < lowest) {
        lowest = acc;
        weakest = pillar;
      }
    }
    return weakest?.label ?? 'Componente Pedagógico';
  }

  Map<String, dynamic> toJson() => {
        'displayName': displayName,
        'cargo': cargo?.name,
        'especialidad': especialidad?.name,
        'onboardingComplete': onboardingComplete,
        'isPremium': isPremium,
        'darkMode': darkMode,
        'streakDays': streakDays,
        'lastStreakDate': lastStreakDate?.toIso8601String(),
        'dailyCompletedToday': dailyCompletedToday,
        'examDate': examDate?.toIso8601String(),
        'topicMastery': topicMastery,
        'pillarCorrect': pillarCorrect,
        'pillarTotal': pillarTotal,
        'tagCorrect': tagCorrect,
        'tagTotal': tagTotal,
        'pillarTimeSpent': pillarTimeSpent,
        'tagTimeSpent': tagTimeSpent,
        'pillarTimedCount': pillarTimedCount,
        'tagTimedCount': tagTimedCount,
        'completedPlanTaskIds': completedPlanTaskIds,
        'planTaskDate': planTaskDate?.toIso8601String(),
        'streakRemindersEnabled': streakRemindersEnabled,
        'acquiredViaPaid': acquiredViaPaid,
        'welcomeOfferExpiresAt': welcomeOfferExpiresAt?.toIso8601String(),
        'diagnosticCompleted': diagnosticCompleted,
        'recentSessions': [
          for (final session in recentSessions) session.toJson(),
        ],
      };

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(dynamic value) {
      if (value == null) return null;
      if (value is DateTime) return value;
      if (value is String) return DateTime.tryParse(value);
      try {
        final converted = (value as dynamic).toDate();
        if (converted is DateTime) return converted;
      } catch (_) {}
      return null;
    }

    Map<String, double> mastery = {};
    final rawMastery = json['topicMastery'];
    if (rawMastery is Map) {
      mastery = rawMastery.map(
        (k, v) => MapEntry(k.toString(), (v as num).toDouble()),
      );
    }

    Map<String, int> readIntMap(String key) {
      final raw = json[key];
      if (raw is! Map) return {};
      return raw.map((k, v) => MapEntry(k.toString(), (v as num).toInt()));
    }

    final rawTasks = json['completedPlanTaskIds'];
    final tasks = rawTasks is List
        ? rawTasks.map((e) => e.toString()).toList()
        : <String>[];

    final timedCount = readIntMap('pillarTimedCount');
    final tagTimed = readIntMap('tagTimedCount');

    final rawSessions = json['recentSessions'];
    final sessions = <RecentSessionSnapshot>[];
    if (rawSessions is List) {
      for (final item in rawSessions.take(RecentSessionSnapshot.maxStored)) {
        if (item is Map) {
          sessions.add(
            RecentSessionSnapshot.fromJson(Map<String, dynamic>.from(item)),
          );
        }
      }
    }

    return UserProfile(
      displayName: (json['displayName'] as String?) ?? '',
      cargo: _parseCargo(json['cargo'] as String?),
      especialidad:
          _enumByName(Especialidad.values, json['especialidad'] as String?),
      onboardingComplete: json['onboardingComplete'] as bool? ?? false,
      isPremium: json['isPremium'] as bool? ?? false,
      darkMode: json['darkMode'] as bool? ?? false,
      streakDays: json['streakDays'] as int? ?? 0,
      lastStreakDate: parseDate(json['lastStreakDate']),
      dailyCompletedToday: json['dailyCompletedToday'] as bool? ?? false,
      examDate: parseDate(json['examDate']),
      topicMastery: mastery,
      pillarCorrect: readIntMap('pillarCorrect'),
      pillarTotal: readIntMap('pillarTotal'),
      tagCorrect: readIntMap('tagCorrect'),
      tagTotal: readIntMap('tagTotal'),
      pillarTimeSpent: TmoStats.timeIfSampled(
        timeSpent: readIntMap('pillarTimeSpent'),
        timedCount: timedCount,
      ),
      tagTimeSpent: TmoStats.timeIfSampled(
        timeSpent: readIntMap('tagTimeSpent'),
        timedCount: tagTimed,
      ),
      pillarTimedCount: timedCount,
      tagTimedCount: tagTimed,
      completedPlanTaskIds: tasks,
      planTaskDate: parseDate(json['planTaskDate']),
      streakRemindersEnabled: json['streakRemindersEnabled'] as bool? ?? false,
      acquiredViaPaid: json['acquiredViaPaid'] == true,
      welcomeOfferExpiresAt: parseDate(json['welcomeOfferExpiresAt']),
      diagnosticCompleted: json['diagnosticCompleted'] == true,
      recentSessions: sessions,
    );
  }
}

T? _enumByName<T extends Enum>(List<T> values, String? name) {
  if (name == null) return null;
  for (final value in values) {
    if (value.name == name) return value;
  }
  return null;
}

/// Migra el valor legacy `rector` al único cargo [CargoAspiracion.directivo].
CargoAspiracion? _parseCargo(String? name) {
  if (name == null) return null;
  if (name == 'rector') return CargoAspiracion.directivo;
  return _enumByName(CargoAspiracion.values, name);
}
