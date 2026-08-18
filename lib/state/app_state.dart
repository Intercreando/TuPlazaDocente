import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../config/app_config.dart';
import '../data/question_bank.dart';
import '../models/enums.dart';
import '../models/question.dart';
import '../models/study_plan.dart';
import '../models/user_profile.dart';
import '../models/knowledge_taxonomy.dart';
import '../services/device_session_service.dart';
import '../services/firebase_sync_service.dart';
import '../services/payment_service.dart';
import '../services/promo_code_service.dart';
import '../services/question_repository.dart';
import '../services/streak_notification_service.dart';
import '../services/study_plan_service.dart';
import '../services/tag_mastery_service.dart';
import '../config/paid_funnel.dart';
import '../services/paid_acquisition_service.dart';
import '../utils/google_ads_tag.dart';
import '../utils/meta_pixel.dart';
import '../utils/paid_traffic.dart';

/// Estado global de progreso, perfil y sesiones.
class AppState extends ChangeNotifier {
  AppState({
    FirebaseSyncService? syncService,
    PaymentService? paymentService,
    StreakNotificationService? notificationService,
    QuestionRepository? questionRepository,
    DeviceSessionService? deviceSessionService,
    PaidAcquisitionService? paidAcquisitionService,
  }) : _sync = syncService ?? FirebaseSyncService(),
       _payments = paymentService ?? PaymentService(),
       _notifications = notificationService ?? StreakNotificationService(),
       _questions = questionRepository ?? QuestionRepository(),
       _devices = deviceSessionService ?? DeviceSessionService(),
       _paidAcquisition = paidAcquisitionService ?? PaidAcquisitionService();

  static const _storageKey = 'tu_plaza_docente_profile_v1';
  static const _checkoutAmountKey = 'pending_checkout_amount_cop';
  static const _checkoutTxKey = 'pending_checkout_transaction_id';
  static const freeDailyLimit = 5;
  static const freeMonthlyShortExams = 1;

  /// Sesiones de práctica libre (además del reto diario) permitidas por día en Gratis.
  static const freePracticeSessionsPerDay = 1;

  final FirebaseSyncService _sync;
  final PaymentService _payments;
  final StreakNotificationService _notifications;
  final QuestionRepository _questions;
  final DeviceSessionService _devices;
  final PaidAcquisitionService _paidAcquisition;
  Timer? _deviceHeartbeat;
  bool _deviceGateBusy = false;
  bool _paidClaimInFlight = false;
  String? _paidClaimSettledUid;

  UserProfile profile = const UserProfile();
  bool ready = false;
  String? lastError;
  String? syncStatus;
  String questionSource = 'local';
  int questionCount = 0;

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
  String examsMonthKey = '';
  int freePracticeSessionsUsed = 0;
  String freePracticeDayKey = '';
  String? activePlanTaskId;

  Question? get currentQuestion =>
      currentQuestions.isEmpty ? null : currentQuestions[currentIndex];

  bool get canStartShortExam => PaidFunnel.canStartShortExam(
    profile: profile,
    monthlyShortExamsUsed: monthlyShortExamsUsed,
    freeMonthlyShortExams: freeMonthlyShortExams,
  );

  bool get isPaidCohort => PaidFunnel.isCohort(profile);

  bool get needsPaidDiagnostic => PaidFunnel.needsDiagnostic(profile);

  bool get welcomeOfferActive => PaidFunnel.welcomeOfferActive(profile);

  int get displayedPremiumPriceCop =>
      PaidFunnel.priceCop(profile, promoPercent: pendingDiscountPercent);

  bool get canStartFreePractice =>
      profile.isPremium ||
      freePracticeSessionsUsed < freePracticeSessionsPerDay;

  bool get canAccessCases => profile.isPremium;
  bool get canAccessSpecialty => profile.isPremium;

  bool get cloudSyncEnabled => _sync.available;
  bool get isAnonymousUser => _sync.isAnonymous;
  String? get authEmail => _sync.email;
  String? get authDisplayName => _sync.displayName;
  String? get authUid => _sync.isAnonymous ? null : _sync.uid;

  DailyStudyPlan get todayPlan {
    final base = StudyPlanService.buildFor(profile);
    final today = DateTime.now();
    final sameDay =
        profile.planTaskDate != null &&
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
      final prefs = await SharedPreferences.getInstance().timeout(
        const Duration(seconds: 3),
      );
      final raw = prefs.getString(_storageKey);
      if (raw != null) {
        profile = UserProfile.fromJson(jsonDecode(raw) as Map<String, dynamic>);
        _refreshDailyFlags();
      }
      monthlyShortExamsUsed = prefs.getInt('monthly_short_exams') ?? 0;
      examsMonthKey = prefs.getString('exams_month_key') ?? '';
      freePracticeSessionsUsed = prefs.getInt('free_practice_used') ?? 0;
      freePracticeDayKey = prefs.getString('free_practice_day') ?? '';
      _refreshQuotaFlags();

      // Mostrar UI cuanto antes; la nube/banco no deben dejar la app colgada.
      ready = true;
      notifyListeners();

      try {
        await _sync.ensureSignedIn().timeout(const Duration(seconds: 8));
        if (_sync.available) {
          final remote = await _sync.loadRemoteProfile().timeout(
            const Duration(seconds: 8),
          );
          if (remote != null && remote.totalAnswers >= profile.totalAnswers) {
            profile = remote;
            _refreshDailyFlags();
            await prefs.setString(_storageKey, jsonEncode(profile.toJson()));
          } else if (profile.onboardingComplete) {
            await _sync.saveRemoteProfile(profile);
            if (remote != null) _mergePaidFunnelFromRemote(remote);
          }
          if (!_sync.isAnonymous) {
            await _claimPaidAcquisitionIfNeeded();
            _identifyMetaPixel();
          }
          syncStatus = _sync.isAnonymous
              ? 'Sesión invitado (nube). Guarda tu cuenta para no perder progreso.'
              : 'Cuenta conectada · progreso en la nube';
        } else {
          syncStatus =
              _sync.lastError ??
              'Modo local: activa Auth anónimo en Firebase para sincronizar.';
        }
      } catch (e) {
        syncStatus = 'Modo local temporal (nube lenta o no disponible).';
        debugPrint('bootstrap sync: $e');
      }

      try {
        await _questions.loadIntoBank().timeout(const Duration(seconds: 20));
        questionSource = _questions.source;
        questionCount = QuestionBank.all.length;
      } catch (e) {
        questionSource = 'local';
        questionCount = QuestionBank.all.length;
        debugPrint('bootstrap questions: $e');
      }

      lastError = null;
      notifyListeners();
      await _syncPremiumDeviceSlot(register: true);
      await _maybeRemindStreak();
    } catch (e) {
      ready = true;
      lastError = 'No pudimos cargar tu progreso. Empezaremos limpio.';
      profile = const UserProfile();
      notifyListeners();
    }
  }

  /// Registra o verifica el cupo de dispositivos Premium (máx. N).
  Future<void> _syncPremiumDeviceSlot({required bool register}) async {
    if (!profile.isPremium || _sync.isAnonymous || !_sync.available) {
      _deviceHeartbeat?.cancel();
      _deviceHeartbeat = null;
      return;
    }
    if (_deviceGateBusy) return;
    _deviceGateBusy = true;
    try {
      final result = register
          ? await _devices.registerPremiumDevice()
          : await _devices.checkPremiumDevice();
      if (!result.allowed && !result.skipped) {
        await _evictForDeviceLimit(result.message);
        return;
      }
      _deviceHeartbeat?.cancel();
      _deviceHeartbeat = Timer.periodic(
        const Duration(minutes: 3),
        (_) => unawaited(refreshPremiumDeviceSlot()),
      );
    } finally {
      _deviceGateBusy = false;
    }
  }

  /// Revalida el dispositivo (resume de app / heartbeat).
  Future<void> refreshPremiumDeviceSlot() async {
    await _syncPremiumDeviceSlot(register: false);
  }

  Future<void> _evictForDeviceLimit(String? message) async {
    _deviceHeartbeat?.cancel();
    _deviceHeartbeat = null;
    final detail =
        message ??
        'Esta cuenta Premium ya está activa en '
            '${AppConfig.maxPremiumDevices} dispositivos. '
            'Cerramos la sesión aquí.';
    await signOut();
    lastError = detail;
    syncStatus = detail;
    notifyListeners();
  }

  @override
  void dispose() {
    _deviceHeartbeat?.cancel();
    super.dispose();
  }

  Future<void> _maybeRemindStreak() async {
    if (!profile.streakRemindersEnabled || profile.dailyCompletedToday) {
      return;
    }
    await _notifications.showStreakReminder(streakDays: profile.streakDays);
  }

  Future<void> persistNow() => _persist();

  Future<void> _persist() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, jsonEncode(profile.toJson()));
      await prefs.setInt('monthly_short_exams', monthlyShortExamsUsed);
      await prefs.setString('exams_month_key', examsMonthKey);
      await prefs.setInt('free_practice_used', freePracticeSessionsUsed);
      await prefs.setString('free_practice_day', freePracticeDayKey);
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
      final sameDay =
          last.year == today.year &&
          last.month == today.month &&
          last.day == today.day;
      if (!sameDay) {
        profile = profile.copyWith(dailyCompletedToday: false);
      }
    }

    final planDate = profile.planTaskDate;
    if (planDate != null) {
      final samePlanDay =
          planDate.year == today.year &&
          planDate.month == today.month &&
          planDate.day == today.day;
      if (!samePlanDay) {
        profile = profile.copyWith(
          completedPlanTaskIds: const [],
          planTaskDate: today,
        );
      }
    }

    _refreshQuotaFlags();
  }

  /// Reinicia cupos diarios/mensuales del plan Gratis.
  void _refreshQuotaFlags() {
    final now = DateTime.now();
    final dayKey =
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}';
    final monthKey = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    if (freePracticeDayKey != dayKey) {
      freePracticeDayKey = dayKey;
      freePracticeSessionsUsed = 0;
    }
    if (examsMonthKey != monthKey) {
      examsMonthKey = monthKey;
      monthlyShortExamsUsed = 0;
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

  /// Actualiza cargo/especialidad/nombre/fecha sin reiniciar el progreso.
  Future<void> updateAspirationProfile({
    required String name,
    required CargoAspiracion cargo,
    required Especialidad especialidad,
    DateTime? examDate,
  }) async {
    profile = profile.copyWith(
      displayName: name.trim().isEmpty ? profile.displayName : name.trim(),
      cargo: cargo,
      especialidad: especialidad,
      examDate: examDate ?? profile.examDate,
      onboardingComplete: true,
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

  Future<bool> activatePremiumWithCode(String code) async {
    try {
      final result = await _payments.activateWithCode(code);
      final remote = await _sync.loadRemoteProfile();
      if (remote != null) {
        profile = remote.copyWith(
          darkMode: profile.darkMode,
          streakRemindersEnabled: profile.streakRemindersEnabled,
        );
      } else if (result.isGrant) {
        profile = profile.copyWith(isPremium: true);
      }
      lastError = null;
      await _persist();
      notifyListeners();
      if (result.isGrant) {
        await _syncPremiumDeviceSlot(register: true);
        lastPromoRedeem = result;
      } else {
        lastPromoRedeem = result;
      }
      return true;
    } catch (e) {
      lastError = e.toString().replaceFirst('Exception: ', '');
      lastPromoRedeem = null;
      notifyListeners();
      return false;
    }
  }

  /// Descuento promocional pendiente (Wompi).
  int? get pendingDiscountPercent => lastPromoRedeem?.isDiscount == true
      ? lastPromoRedeem!.discountPercent
      : _sync.pendingDiscountPercent;

  String? get pendingDiscountCode => lastPromoRedeem?.isDiscount == true
      ? lastPromoRedeem!.code
      : _sync.pendingDiscountCode;

  /// Último canje de código (para mostrar descuento en Premium).
  PromoRedeemResult? lastPromoRedeem;

  Future<PremiumCheckoutSession> startPremiumCheckout() async {
    try {
      final session = await _payments.createCheckout();
      await rememberCheckoutAmount(
        session.amountCop,
        transactionId: session.reference,
      );
      lastError = null;
      return session;
    } catch (e) {
      lastError = e.toString().replaceFirst('Exception: ', '');
      notifyListeners();
      rethrow;
    }
  }

  /// Alias legado (antes Mercado Pago).
  Future<PremiumCheckoutSession> startMercadoPagoCheckout() =>
      startPremiumCheckout();

  /// Guarda el monto real del checkout (para Purchase al volver de Wompi).
  Future<void> rememberCheckoutAmount(
    double amountCop, {
    String? transactionId,
  }) async {
    if (amountCop <= 0) return;
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble(_checkoutAmountKey, amountCop);
      if (transactionId != null && transactionId.isNotEmpty) {
        await prefs.setString(_checkoutTxKey, transactionId);
      }
    } catch (e) {
      debugPrint('rememberCheckoutAmount: $e');
    }
  }

  /// Lee y limpia el monto pendiente de checkout; fallback al precio de lista.
  Future<({double value, String? transactionId})>
  takeCheckoutPurchaseValue() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final stored = prefs.getDouble(_checkoutAmountKey);
      final tx = prefs.getString(_checkoutTxKey);
      if (stored != null && stored > 0) {
        await prefs.remove(_checkoutAmountKey);
        await prefs.remove(_checkoutTxKey);
        return (value: stored, transactionId: tx);
      }
    } catch (e) {
      debugPrint('takeCheckoutPurchaseValue: $e');
    }
    return (value: AppConfig.premiumPriceCop, transactionId: null);
  }

  Future<bool> enableStreakReminders() async {
    final granted = await _notifications.requestPermission();
    if (!granted) {
      lastError =
          'Permiso de notificaciones denegado. Actívalo en el navegador para la racha.';
      notifyListeners();
      return false;
    }
    profile = profile.copyWith(streakRemindersEnabled: true);
    lastError = null;
    await _persist();
    await _notifications.showStreakReminder(streakDays: profile.streakDays);
    notifyListeners();
    return true;
  }

  Future<void> disableStreakReminders() async {
    profile = profile.copyWith(streakRemindersEnabled: false);
    await _persist();
    notifyListeners();
  }

  Future<void> refreshPremiumFromCloud() async {
    final remote = await _sync.loadRemoteProfile();
    if (remote == null) return;
    profile = profile.copyWith(isPremium: remote.isPremium);
    _mergePaidFunnelFromRemote(remote);
    await _persist();
    notifyListeners();
    if (profile.isPremium) {
      await _syncPremiumDeviceSlot(register: true);
    }
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

  Future<bool> sendPasswordReset(String email) async {
    final ok = await _sync.sendPasswordReset(email: email);
    lastError = _sync.lastError;
    notifyListeners();
    return ok;
  }

  Future<bool> registerWithEmail(String email, String password) async {
    final ok = await _sync.registerWithEmail(email: email, password: password);
    if (!ok) {
      lastError = _sync.lastError;
      notifyListeners();
      return false;
    }
    await _reloadAfterAuth();
    if (_sync.lastAuthWasRegistration) {
      MetaPixel.completeRegistration(
        method: 'email',
        email: _sync.email,
        externalId: _sync.uid,
      );
      GoogleAdsTag.completeRegistration();
    }
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
    if (_sync.lastAuthWasRegistration) {
      MetaPixel.completeRegistration(
        method: 'google',
        email: _sync.email,
        externalId: _sync.uid,
      );
      GoogleAdsTag.completeRegistration();
    }
    return true;
  }

  /// Cierra la cuenta registrada, guarda su progreso en la nube y deja un invitado limpio.
  /// Conserva solo la preferencia de tema oscuro en el dispositivo.
  Future<bool> signOut() async {
    try {
      _deviceHeartbeat?.cancel();
      _deviceHeartbeat = null;
      _paidClaimSettledUid = null;
      PaidTraffic.clearClaimSettled();
      final keepDarkMode = profile.darkMode;

      // 1) Persistir progreso de la cuenta registrada antes de soltar el UID.
      if (!_sync.isAnonymous && _sync.available) {
        try {
          await _sync.saveRemoteProfile(profile);
        } catch (e) {
          debugPrint('signOut: no se pudo guardar remoto previo: $e');
        }
      }

      // 2) Cortar entrenamiento en curso.
      _resetSessionFields();

      // 3) Firebase: salir y volver a anónimo (nuevo UID).
      final switched = await _sync.signOutToAnonymous();
      if (!switched) {
        lastError = _sync.lastError ?? 'No se pudo cerrar sesión por completo.';
        syncStatus = lastError;
        notifyListeners();
        return false;
      }

      // 4) Perfil invitado fresco (sin Premium ni progreso heredado).
      profile = UserProfile(darkMode: keepDarkMode);
      lastResult = null;
      lastError = null;

      // 5) Si el nuevo UID ya tiene algo remoto, úsalo; si no, queda limpio.
      if (_sync.available) {
        try {
          final remote = await _sync.loadRemoteProfile();
          if (remote != null) {
            profile = remote.copyWith(darkMode: keepDarkMode);
            _refreshDailyFlags();
          }
        } catch (e) {
          debugPrint('signOut: carga remota del invitado: $e');
        }
      }

      await _persist();
      syncStatus = _sync.available
          ? 'Sesión invitado (nube). Tu cuenta quedó guardada; puedes volver a entrar cuando quieras.'
          : 'Sesión invitado local. Tu cuenta en la nube quedó guardada.';
      notifyListeners();
      return true;
    } catch (e) {
      lastError = 'No se pudo cerrar sesión. Intenta de nuevo.';
      debugPrint('signOut: $e');
      notifyListeners();
      return false;
    }
  }

  Future<void> _reloadAfterAuth() async {
    final remote = await _sync.loadRemoteProfile();
    if (remote != null && remote.totalAnswers >= profile.totalAnswers) {
      profile = remote;
      _refreshDailyFlags();
    } else {
      await _sync.saveRemoteProfile(profile);
      if (remote != null) _mergePaidFunnelFromRemote(remote);
    }
    if (_sync.email != null &&
        (profile.displayName.isEmpty || profile.displayName == 'Aspirante')) {
      final name = _sync.displayName ?? _sync.email!.split('@').first;
      profile = profile.copyWith(displayName: name);
    }
    syncStatus = 'Cuenta conectada · progreso en la nube';
    lastError = null;
    await _claimPaidAcquisitionIfNeeded();
    _identifyMetaPixel();
    await _persist();
    notifyListeners();
    await _syncPremiumDeviceSlot(register: true);
  }

  /// Correo y UID para matching de Meta (CAPI + visitas siguientes).
  void _identifyMetaPixel() {
    if (_sync.isAnonymous) return;
    MetaPixel.identify(email: _sync.email, externalId: _sync.uid);
  }

  void _mergePaidFunnelFromRemote(UserProfile remote) {
    profile = profile.copyWith(
      acquiredViaPaid: remote.acquiredViaPaid || profile.acquiredViaPaid,
      welcomeOfferExpiresAt:
          remote.welcomeOfferExpiresAt ?? profile.welcomeOfferExpiresAt,
      diagnosticCompleted:
          remote.diagnosticCompleted || profile.diagnosticCompleted,
    );
  }

  /// Si el clic fue de pauta y la cuenta es nueva, el servidor sella oferta 24 h.
  /// Una sola invocación por uid (no hay reintento en bucle).
  Future<void> _claimPaidAcquisitionIfNeeded() async {
    if (_sync.isAnonymous || !_sync.available) return;
    final uid = _sync.uid;
    if (uid == null || uid.isEmpty) return;
    if (_paidClaimInFlight) return;
    if (PaidTraffic.isClaimSettledFor(uid) || _paidClaimSettledUid == uid) {
      return;
    }
    if (profile.acquiredViaPaid) {
      PaidTraffic.markClaimSettled(uid);
      _paidClaimSettledUid = uid;
      return;
    }
    if (!PaidTraffic.isPaid || profile.isPremium) return;

    _paidClaimInFlight = true;
    try {
      final claim = await _paidAcquisition.claim();
      if (claim == null) return;
      if (claim.rejected) {
        PaidTraffic.markClaimSettled(uid);
        _paidClaimSettledUid = uid;
        return;
      }
      if (!claim.acquiredViaPaid) return;
      profile = profile.copyWith(
        acquiredViaPaid: true,
        welcomeOfferExpiresAt:
            claim.welcomeOfferExpiresAt ?? profile.welcomeOfferExpiresAt,
      );
      PaidTraffic.markClaimSettled(uid);
      _paidClaimSettledUid = uid;
    } catch (e) {
      debugPrint('claimPaidAcquisitionIfNeeded: $e');
    } finally {
      _paidClaimInFlight = false;
    }
  }

  bool startSession({
    required SessionMode mode,
    CompetencyPillar? pillar,
    Especialidad? specialty,
    int count = 10,
    bool casesOnly = false,
    String? planTaskId,
    int? difficultyLevel,
    int? minDifficultyLevel,
    KnowledgeCode? knowledgeCode,
  }) {
    _refreshQuotaFlags();

    if (mode == SessionMode.exam && !canStartShortExam) {
      lastError = profile.acquiredViaPaid
          ? 'El simulacro con tiempo es Premium en cuentas de campaña. El diagnóstico y las 5 del día siguen disponibles.'
          : 'Ya usaste tu simulacro gratis del mes. Activa Premium para continuar.';
      notifyListeners();
      return false;
    }

    if (!profile.isPremium) {
      if (casesOnly) {
        lastError =
            'Los casos del colegio son Premium. En Gratis: las 5 del día y 1 práctica.';
        notifyListeners();
        return false;
      }
      if (specialty != null) {
        lastError =
            'La práctica por especialidad es Premium. Activa Premium o usa el reto diario.';
        notifyListeners();
        return false;
      }
      final countsAsFreePractice =
          mode == SessionMode.practice && !casesOnly && specialty == null;
      if (countsAsFreePractice && !canStartFreePractice) {
        lastError =
            'Ya usaste tu práctica gratis de hoy. Mañana se reinicia, o activa Premium para practicar sin límite.';
        notifyListeners();
        return false;
      }
    }

    final resolvedSpecialty =
        specialty ??
        _specialtyForSession(mode, pillar: pillar, casesOnly: casesOnly);

    // En Gratis, la especialidad automática del cargo no debe saltarse el paywall.
    final effectiveSpecialty = profile.isPremium
        ? resolvedSpecialty
        : specialty;

    currentQuestions = QuestionBank.forSession(
      mode: mode,
      pillar: pillar,
      specialty: effectiveSpecialty,
      count: mode == SessionMode.dailyStreak
          ? freeDailyLimit
          : mode == SessionMode.speedBattle
          ? 30
          : count,
      casesOnly: casesOnly,
      difficultyLevel: difficultyLevel,
      minDifficultyLevel: minDifficultyLevel,
      knowledgeCode: knowledgeCode,
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

    if (!profile.isPremium &&
        mode == SessionMode.practice &&
        !casesOnly &&
        specialty == null) {
      freePracticeSessionsUsed += 1;
      _persist();
    }

    notifyListeners();
    return true;
  }

  /// Prioriza Gestión directiva para Rector/Directivo cuando no hay foco de pilar.
  Especialidad? _specialtyForSession(
    SessionMode mode, {
    CompetencyPillar? pillar,
    bool casesOnly = false,
  }) {
    if (mode == SessionMode.speedBattle || mode == SessionMode.dailyStreak) {
      return null;
    }

    final esGestion = profile.cargo?.esGestionInstitucional == true;

    if (mode == SessionMode.diagnostic || casesOnly) {
      if (esGestion) return Especialidad.directivos;
      return profile.especialidad;
    }

    // Con pilar explícito (plan diario) respetamos el foco del radar.
    if (pillar != null) return null;

    if (esGestion) return Especialidad.directivos;
    if (mode == SessionMode.practice || mode == SessionMode.exam) {
      return profile.especialidad;
    }
    return null;
  }

  bool startSingleQuestion(Question question) {
    if (!profile.isPremium) {
      lastError =
          'Abrir casos sueltos es Premium. Activa Premium para el banco completo.';
      notifyListeners();
      return false;
    }
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
    return true;
  }

  bool startPlanTask(StudyTask task) {
    if (!profile.isPremium &&
        task.mode == SessionMode.exam &&
        (task.minDifficultyLevel ?? 0) >= 3) {
      lastError =
          'Alta exigencia es Premium. En Gratis: las 5 del día y 1 práctica.';
      notifyListeners();
      return false;
    }
    return startSession(
      mode: task.mode,
      pillar: task.isCaseStudy || task.mixPillars ? null : task.pillar,
      count: task.questionCount,
      casesOnly: task.isCaseStudy,
      planTaskId: task.id,
      minDifficultyLevel: task.minDifficultyLevel,
    );
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

  Future<bool> submitAndAdvance({bool allowUnanswered = false}) async {
    final question = currentQuestion;
    final selected = selectedOption;
    if (question == null) return false;
    if (selected == null && !allowUnanswered) return false;

    final started = questionStartedAt ?? DateTime.now();
    final seconds = DateTime.now().difference(started).inSeconds.clamp(1, 600);
    final correct = selected != null && question.isCorrect(selected);

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
    notifyListeners();
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
    mastery[question.topic] = (prev + (correct ? 0.08 : -0.06)).clamp(
      0.05,
      0.98,
    );

    // Mapa de Maestría por etiquetas del cerebro (norma / teoría / referente).
    final tagCorrect = Map<String, int>.from(profile.tagCorrect);
    final tagTotal = Map<String, int>.from(profile.tagTotal);
    final seen = <String>{};
    for (final tag in question.knowledgeTags) {
      final key = tag.code.name;
      if (!seen.add(key)) continue;
      tagTotal[key] = (tagTotal[key] ?? 0) + 1;
      if (correct) {
        tagCorrect[key] = (tagCorrect[key] ?? 0) + 1;
      }
    }

    profile = profile.copyWith(
      pillarCorrect: pillarCorrect,
      pillarTotal: pillarTotal,
      topicMastery: mastery,
      tagCorrect: tagCorrect,
      tagTotal: tagTotal,
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
    if (currentMode == SessionMode.diagnostic) {
      profile = profile.copyWith(diagnosticCompleted: true);
    }
    if (activePlanTaskId != null) {
      _markPlanTaskDone(activePlanTaskId!);
    }

    await _persist();
    notifyListeners();
  }

  void _markPlanTaskDone(String taskId) {
    final today = DateTime.now();
    final sameDay =
        profile.planTaskDate != null &&
        profile.planTaskDate!.year == today.year &&
        profile.planTaskDate!.month == today.month &&
        profile.planTaskDate!.day == today.day;
    final ids = sameDay ? [...profile.completedPlanTaskIds] : <String>[];
    if (!ids.contains(taskId)) {
      ids.add(taskId);
    }
    profile = profile.copyWith(completedPlanTaskIds: ids, planTaskDate: today);
  }

  Future<void> _registerStreak() async {
    final today = DateTime.now();
    final last = profile.lastStreakDate;
    var streak = profile.streakDays;

    if (last == null) {
      streak = 1;
    } else {
      final diff = DateTime(
        today.year,
        today.month,
        today.day,
      ).difference(DateTime(last.year, last.month, last.day)).inDays;
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

  void _resetSessionFields() {
    currentQuestions = [];
    currentMode = null;
    currentIndex = 0;
    selectedOption = null;
    revealed = false;
    currentAnswers.clear();
    questionStartedAt = null;
    sessionStartedAt = null;
    activePlanTaskId = null;
  }

  void clearSession() {
    _resetSessionFields();
    notifyListeners();
  }

  String studyFocusMessage() {
    // Prioriza el Mapa de Maestría por etiquetas (sensación de currículo, no de conteo).
    if (profile.tagTotal.isNotEmpty || profile.totalAnswers > 0) {
      return TagMasteryService.recommendationMessage(profile);
    }
    final weak = profile.weakestPillarLabel;
    final numerica =
        (profile.pillarAccuracy(CompetencyPillar.aptitudNumerica) * 100)
            .round();
    final pedagogico =
        (profile.pillarAccuracy(CompetencyPillar.pedagogico) * 100).round();
    if ((profile.pillarTotal[CompetencyPillar.pedagogico.name] ?? 0) == 0 &&
        (profile.pillarTotal[CompetencyPillar.aptitudNumerica.name] ?? 0) ==
            0) {
      return 'Completa las 5 del día para ver en qué temas vas.';
    }
    return 'Tu Aptitud Numérica está al $numerica%, pero tu $weak '
        'necesita foco hoy (Pedagógico en ~$pedagogico%).';
  }
}
