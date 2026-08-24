import '../config/app_config.dart';
import '../config/paid_funnel_config.dart';
import '../models/user_profile.dart';

/// Reglas de pauta vs orgánico (precio, cupo de examen, diagnóstico).
abstract final class PaidFunnel {
  static bool isCohort(UserProfile profile) => profile.acquiredViaPaid;

  static bool needsDiagnostic(UserProfile profile) {
    return profile.acquiredViaPaid &&
        !profile.isPremium &&
        !profile.diagnosticCompleted;
  }

  static bool welcomeOfferActive(UserProfile profile, {DateTime? now}) {
    if (profile.isPremium) return false;
    final exp = profile.welcomeOfferExpiresAt;
    if (exp == null) return false;
    return (now ?? DateTime.now()).isBefore(exp);
  }

  static Duration welcomeRemaining(UserProfile profile, {DateTime? now}) {
    final exp = profile.welcomeOfferExpiresAt;
    if (exp == null) return Duration.zero;
    final left = exp.difference(now ?? DateTime.now());
    return left.isNegative ? Duration.zero : left;
  }

  /// Orgánico: 1 simulacro/mes. Pauta: Examen Real solo con Premium.
  static bool canStartShortExam({
    required UserProfile profile,
    required int monthlyShortExamsUsed,
    required int freeMonthlyShortExams,
  }) {
    if (profile.isPremium) return true;
    if (profile.acquiredViaPaid) return false;
    return monthlyShortExamsUsed < freeMonthlyShortExams;
  }

  /// El menor entre oferta de bienvenida y un código promo (si aplica).
  static int priceCop(UserProfile profile, {int? promoPercent}) {
    var price = PaidFunnelConfig.listPriceCop;
    if (welcomeOfferActive(profile)) {
      price = PaidFunnelConfig.welcomePriceCop;
    }
    final pct = promoPercent ?? 0;
    if (pct > 0) {
      var promo = (PaidFunnelConfig.listPriceCop * (100 - pct) / 100).round();
      if (promo < 1000) promo = 1000;
      if (promo < price) price = promo;
    }
    return price;
  }

  static String priceLabel(UserProfile profile, {int? promoPercent}) {
    return AppConfig.formatCop(priceCop(profile, promoPercent: promoPercent));
  }
}
