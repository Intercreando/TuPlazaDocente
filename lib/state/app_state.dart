import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../data/question_bank.dart';
import '../models/enums.dart';
import '../models/question.dart';
import '../models/study_plan.dart';
import '../models/user_profile.dart';
import '../services/firebase_sync_service.dart';
import '../services/study_plan_service.dart';

/// Estado global de progreso, perfil y sesiones.
class AppState extends ChangeNotifier {
  AppState({FirebaseSyncService? syncService})
      : _sync = syncService ?? FirebaseSyncService();

  static const _storageKey = 'tu_plaza_docente_profile_v1';
  static const freeDailyLimit = 5;
  static const freeMonthlyShortExams = 1;

  final FirebaseSyncService _sync;

  UserProfile profile = const UserProfile();
  bool ready = false;
  String? lastError;
  String? syncStatus;

  List<Question> currentQuestions = [];
  SessionMode? currentMode;
  int currentIndex = 0;
  int? selectedOption;
  bool revealed = false;
  final List<AnswerRecord> currentAnswers = [];
  DateTime? questionStartedAt;
  DateTime? sessionStartedAt;
  SessionResult? lastResult;
  int monthlyShortExamsUsed = 0;
  String? activePlanTaskId;

  Question? get currentQuestion =>
      currentQuestions.isEmpty ? null : currentQuestions[currentIndex];

  bool get canStartShortExam =>
      profile.isPremium || monthlyShortExamsUsed < freeMonthlyShortExams;

  bool get cloudSyncEnabled => _sync.available;
  bool get isAnonymousUser => _sync.isAnonymous;
  String? get authEmail => _sync.email;
  String? get authDisplayName => _sync.displayName;

  DailyStudyPlan get todayPlan {
    final base = StudyPlanService.buildFor(profile);
    final today = DateTime.now();
    final sameDay = profile.planTaskDate != null &&
        profile.planTaskDate!.year == today.year &&
        profile.planTaskDate!.month == today.month &&
        profile.planTaskDate!.day == today.day;
    final done = sameDay ? profile.completedPlanTaskIds.toSet() : <String>{};
    return DailyStudyPlan(
      date: base.date,
      daysRemaining: base.daysRemaining,
      intensityLabel: base.intensityLabel,
      focusPillar: base.focusPillar,
      summary: base.summary,
      tasks: base.tasks
          .map((t) => t.copyWith(completed: done.contains(t.id)))
          .toList(),
    );
  }

  Future<void> bootstrap() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getString(_storageKey);
      if (raw != null) {
        profile = UserProfile.fromJson(
          jsonDecode(raw) as Map<String, dynamic>,
        );
        _refreshDailyFlags();
      }
      monthlyShortExamsUsed = prefs.getInt('monthly_short_exams') ?? 0;

      await _sync.ensureSignedIn();
      if (_sync.available) {
        final remote = await _sync.loadRemoteProfile();
        if (remote != null && remote.totalAnswers >= profile.totalAnswers) {
          profile = remote;
          _refreshDailyFlags();
          await prefs.setString(_storageKey, jsonEncode(profile.toJson()));
        } else if (profile.onboardingComplete) {
          await _sync.saveRemoteProfile(profile);
        }
        syncStatus = _sync.isAnonymous
            ? 'Sesión invitado (nube). Guarda tu cuenta para no perder progreso.'
            : 'Cuenta conectada · progreso en la nube';
      } else {
        syncStatus = _sync.lastError ??
            'Modo local: activa Auth anónimo en Firebase para sincronizar.';
      }

      ready = true;
      lastError = null;
      notifyListeners();
    } catch (e) {
      ready = true;
      lastError = 'No pudimos cargar tu progreso. Empezaremos limpio.';
      profile = const UserProfile();
      notifyListeners();
    }
  }

  Future<void> persistNow() => _persist();

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, jsonEncode(profile.toJson()));
      await prefs.setInt('monthly_short_exams', monthlyShortExamsUsed);
      if (_sync.available) {
        await _sync.saveRemoteProfile(profile);
        if (_sync.lastError != null) {
          syncStatus = _sync.lastError;
        }
      }
    } catch (_) {
      lastError = 'No se pudo guardar el progreso en este dispositivo.';
      notifyListeners();
    }
  }

  void _refreshDailyFlags() {
    final today = DateTime.now();
    final last = profile.lastStreakDate;
    if (last != null) {
      final sameDay = last.year == today.year &&
          last.month == today.month &&
          last.day == today.day;
      if (!sameDay) {
        profile = profile.copyWith(dailyCompletedToday: false);
      }
    }

    final planDate = profile.planTaskDate;
    if (planDate != null) {
      final samePlanDay = planDate.year == today.year &&
          planDate.month == today.month &&
          planDate.day == today.day;
      if (!samePlanDay) {
        profile = profile.copyWith(
          completedPlanTaskIds: const [],
          planTaskDate: today,
        );
      }
    }
  }

  Future<void> completeOnboarding({
    required String name,
    required CargoAspiracion cargo,
    required Especialidad especialidad,
    DateTime? examDate,
  }) async {
    profile = profile.copyWith(
      displayName: name.trim().isEmpty ? 'Aspirante' : name.trim(),
      cargo: cargo,
      especialidad: especialidad,
      examDate: examDate,
      onboardingComplete: true,
      planTaskDate: DateTime.now(),
      completedPlanTaskIds: const [],
    );
    await _persist();
    notifyListeners();
  }

  Future<void> updateExamDate(DateTime date) async {
    profile = profile.copyWith(examDate: date);
    await _persist();
    notifyListeners();
  }

  Future<void> toggleDarkMode() async {
    profile = profile.copyWith(darkMode: !profile.darkMode);
    await _persist();
    notifyListeners();
  }

  Future<void> activatePremiumDemo() async {
    profile = profile.copyWith(isPremium: true);
    await _persist();
    notifyListeners();
  }

  Future<bool> activatePremiumWithCode(String code) async {
    final normalized = code.trim().toUpperCase();
    if (!AppConfig.premiumAccessCodes.contains(normalized)) {
      lastError = 'Código inválido. Verifica e intenta de nuevo.';
      notifyListeners();
      return false;
    }
    profile = profile.copyWith(isPremium: true);
    lastError = null;
    await _persist();
    notifyListeners();
    return true;
  }

  Future<bool> signInWithEmail(String email, String password) async {
    final ok = await _sync.signInWithEmail(email: email, password: password);
    if (!ok) {
      lastError = _sync.lastError;
      notifyListeners();
      return false;
    }
    await _reloadAfterAuth();
    return true;
  }

  Future<bool> registerWithEmail(String email, String password) async {
    final ok = await _sync.registerWithEmail(email: email, password: password);
    if (!ok) {
      lastError = _sync.lastError;
      notifyListeners();
      return false;
    }
    await _reloadAfterAuth();
    return true;
  }

  Future<bool> signInWithGoogle() async {
    final ok = await _sync.signInWithGoogle();
    if (!ok) {
      lastError = _sync.lastError;
      notifyListeners();
      return false;
    }
    await _reloadAfterAuth();
    return true;
  }

  Future<void> signOut() async {
    await _sync.signOutToAnonymous();
    syncStatus = _sync.available
        ? 'Sesión invitado (nube)'
        : 'Modo local';
    notifyListeners();
  }

  Future<void> _reloadAfterAuth() async {
    final remote = await _sync.loadRemoteProfile();
    if (remote != null && remote.totalAnswers >= profile.totalAnswers) {
      profile = remote;
      _refreshDailyFlags();
    } else {
      await _sync.saveRemoteProfile(profile);
    }
    if (_sync.email != null &&
        (profile.displayName.isEmpty || profile.displayName == 'Aspirante')) {
      final name = _sync.displayName ?? _sync.email!.split('@').first;
      profile = profile.copyWith(displayName: name);
    }
    syncStatus = 'Cuenta conectada · progreso en la nube';
    lastError = null;
    await _persist();
    notifyListeners();
  }

  void startSession({
    required SessionMode mode,
    CompetencyPillar? pillar,
    Especialidad? specialty,
    int count = 10,
    bool casesOnly = false,
    String? planTaskId,
  }) {
    if (mode == SessionMode.exam && !canStartShortExam) {
      lastError =
          'Ya usaste tu simulacro gratis del mes. Activa Premium para continuar.';
      notifyListeners();
      return;
    }

    currentQuestions = QuestionBank.forSession(
      mode: mode,
      pillar: pillar,
      specialty: specialty,
      count: mode == SessionMode.dailyStreak
          ? freeDailyLimit
          : mode == SessionMode.speedBattle
              ? 30
              : count,
      casesOnly: casesOnly,
    );
    currentMode = mode;
    currentIndex = 0;
    selectedOption = null;
    revealed = false;
    currentAnswers.clear();
    lastResult = null;
    lastError = null;
    activePlanTaskId = planTaskId;
    sessionStartedAt = DateTime.now();
    questionStartedAt = DateTime.now();
    notifyListeners();
  }

  void startPlanTask(StudyTask task) {
    startSession(
      mode: task.mode,
      pillar: task.isCaseStudy ? null : task.pillar,
      count: task.questionCount,
      casesOnly: task.isCaseStudy,
      planTaskId: task.id,
    );
  }

  void startSingleQuestion(Question question) {
    currentQuestions = [question];
    currentMode = SessionMode.practice;
    currentIndex = 0;
    selectedOption = null;
    revealed = false;
    currentAnswers.clear();
    lastResult = null;
    lastError = null;
    activePlanTaskId = null;
    sessionStartedAt = DateTime.now();
    questionStartedAt = DateTime.now();
    notifyListeners();
  }

  void selectOption(int index) {
    if (revealed && currentMode != SessionMode.exam) return;
    selectedOption = index;
    notifyListeners();
  }

  void revealPracticeAnswer() {
    if (selectedOption == null || currentQuestion == null) return;
    revealed = true;
    notifyListeners();
  }

  Future<bool> submitAndAdvance({bool forceExamReveal = false}) async {
    final question = currentQuestion;
    final selected = selectedOption;
    if (question == null || selected == null) return false;

    final started = questionStartedAt ?? DateTime.now();
    final seconds = DateTime.now().difference(started).inSeconds.clamp(1, 600);
    final correct = question.isCorrect(selected);

    currentAnswers.add(
      AnswerRecord(
        questionId: question.id,
        selectedIndex: selected,
        correct: correct,
        secondsSpent: seconds,
        pillar: question.pillar,
        topic: question.topic,
      ),
    );

    _applyMastery(question, correct);

    final isLast = currentIndex >= currentQuestions.length - 1;
    if (isLast) {
      await _finishSession();
      return true;
    }

    currentIndex += 1;
    selectedOption = null;
    revealed = false;
    questionStartedAt = DateTime.now();
    if (currentMode == SessionMode.speedBattle) {
      await _persist();
    } else {
      notifyListeners();
    }
    return false;
  }

  void _applyMastery(Question question, bool correct) {
    final pillarKey = question.pillar.name;
    final pillarCorrect = Map<String, int>.from(profile.pillarCorrect);
    final pillarTotal = Map<String, int>.from(profile.pillarTotal);
    pillarTotal[pillarKey] = (pillarTotal[pillarKey] ?? 0) + 1;
    if (correct) {
      pillarCorrect[pillarKey] = (pillarCorrect[pillarKey] ?? 0) + 1;
    }

    final mastery = Map<String, double>.from(profile.topicMastery);
    final prev = mastery[question.topic] ?? 0.45;
    mastery[question.topic] =
        (prev + (correct ? 0.08 : -0.06)).clamp(0.05, 0.98);

    profile = profile.copyWith(
      pillarCorrect: pillarCorrect,
      pillarTotal: pillarTotal,
      topicMastery: mastery,
    );
  }

  Future<void> _finishSession() async {
    final started = sessionStartedAt ?? DateTime.now();
    lastResult = SessionResult(
      mode: currentMode ?? SessionMode.practice,
      answers: List.unmodifiable(currentAnswers),
      startedAt: started,
      finishedAt: DateTime.now(),
    );

    if (currentMode == SessionMode.dailyStreak) {
      await _registerStreak();
    }
    if (currentMode == SessionMode.exam && !profile.isPremium) {
      monthlyShortExamsUsed += 1;
    }
    if (activePlanTaskId != null) {
      _markPlanTaskDone(activePlanTaskId!);
    }

    await _persist();
    notifyListeners();
  }

  void _markPlanTaskDone(String taskId) {
    final today = DateTime.now();
    final sameDay = profile.planTaskDate != null &&
        profile.planTaskDate!.year == today.year &&
        profile.planTaskDate!.month == today.month &&
        profile.planTaskDate!.day == today.day;
    final ids = sameDay
        ? [...profile.completedPlanTaskIds]
        : <String>[];
    if (!ids.contains(taskId)) {
      ids.add(taskId);
    }
    profile = profile.copyWith(
      completedPlanTaskIds: ids,
      planTaskDate: today,
    );
  }

  Future<void> _registerStreak() async {
    final today = DateTime.now();
    final last = profile.lastStreakDate;
    var streak = profile.streakDays;

    if (last == null) {
      streak = 1;
    } else {
      final diff = DateTime(today.year, today.month, today.day)
          .difference(DateTime(last.year, last.month, last.day))
          .inDays;
      if (diff == 0) {
        // Ya contó hoy.
      } else if (diff == 1) {
        streak += 1;
      } else {
        streak = 1;
      }
    }

    profile = profile.copyWith(
      streakDays: streak,
      lastStreakDate: today,
      dailyCompletedToday: true,
    );
  }

  void clearSession() {
    currentQuestions = [];
    currentMode = null;
    currentIndex = 0;
    selectedOption = null;
    revealed = false;
    currentAnswers.clear();
    questionStartedAt = null;
    sessionStartedAt = null;
    activePlanTaskId = null;
    notifyListeners();
  }

  String studyFocusMessage() {
    final weak = profile.weakestPillarLabel;
    final numerica =
        (profile.pillarAccuracy(CompetencyPillar.aptitudNumerica) * 100).round();
    final pedagogico =
        (profile.pillarAccuracy(CompetencyPillar.pedagogico) * 100).round();
    if ((profile.pillarTotal[CompetencyPillar.pedagogico.name] ?? 0) == 0 &&
        (profile.pillarTotal[CompetencyPillar.aptitudNumerica.name] ?? 0) ==
            0) {
      return 'Completa tu reto diario para activar el Radar de Competencias.';
    }
    return 'Tu Aptitud Numérica está al $numerica%, pero tu $weak '
        'necesita foco hoy (Pedagógico en ~$pedagogico%).';
  }
}
