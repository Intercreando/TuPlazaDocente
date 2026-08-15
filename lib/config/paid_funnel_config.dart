/// Constantes del embudo de pauta (no aplica al tráfico orgánico).
abstract final class PaidFunnelConfig {
  /// Precio de lista (igual que [AppConfig.premiumPriceCop]).
  static const int listPriceCop = 89900;

  /// Precio de bienvenida 24 h para cuentas adquiridas por anuncio.
  static const int welcomePriceCop = 69900;

  /// Ventana real de la oferta; no se reinicia al recargar.
  static const Duration welcomeDuration = Duration(hours: 24);

  /// Cuentas más viejas no pueden “reclamarse” como pauta.
  static const Duration maxAccountAgeToClaim = Duration(hours: 48);
}
