import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/admin_config.dart';
import '../config/app_config.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/google_ads_tag.dart';
import '../utils/meta_pixel.dart';
import '../utils/open_external_url.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/legal_footer_links.dart';

/// Paywall freemium con Wompi (Cloud Function) / código.
class PremiumScreen extends StatefulWidget {
  const PremiumScreen({super.key});

  @override
  State<PremiumScreen> createState() => _PremiumScreenState();
}

class _PremiumScreenState extends State<PremiumScreen> {
  final _codeController = TextEditingController();
  bool _busy = false;
  String? _returnStatus;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final status = GoRouterState.of(context).uri.queryParameters['status'];
    if (status != null && status != _returnStatus) {
      _returnStatus = status;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _handleReturnStatus(status);
      });
    }
  }

  Future<void> _handleReturnStatus(String status) async {
    final state = context.read<AppState>();
    final messenger = ScaffoldMessenger.of(context);
    if (status == 'success' || status == 'pending') {
      final wasPremium = state.profile.isPremium;
      var purchaseTracked = false;

      Future<void> tryTrackPurchase({required bool paidConfirmed}) async {
        if (purchaseTracked || wasPremium || !paidConfirmed) {
          return;
        }
        final purchase = await state.takeCheckoutPurchaseValue();
        MetaPixel.purchase(
          value: purchase.value,
          currency: 'COP',
          contentName: 'Premium convocatoria',
          email: state.authEmail,
          externalId: state.authUid,
        );
        GoogleAdsTag.purchase(
          value: purchase.value,
          currency: 'COP',
          transactionId: purchase.transactionId,
        );
        purchaseTracked = true;
      }

      await state.refreshPremiumFromCloud();
      if (!mounted) return;
      // Wompi ya confirmó el pago en la URL; no esperar el webhook de Premium.
      await tryTrackPurchase(
        paidConfirmed: status == 'success' || state.profile.isPremium,
      );

      // Webhook puede tardar unos segundos tras el redirect de Wompi.
      if (status == 'success' && !state.profile.isPremium) {
        await Future<void>.delayed(const Duration(seconds: 3));
        if (!mounted) return;
        await state.refreshPremiumFromCloud();
        await tryTrackPurchase(paidConfirmed: true);
      }

      if (!mounted) return;
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            state.profile.isPremium
                ? 'Pago confirmado. ¡Ya eres Premium!'
                : 'Pago recibido. Si aún no aparece Premium, espera unos segundos y recarga.',
          ),
        ),
      );
    } else if (status == 'failure') {
      messenger.showSnackBar(
        const SnackBar(
          content: Text('El pago no se completó. Puedes intentar de nuevo.'),
        ),
      );
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _openWompiCheckout() async {
    final state = context.read<AppState>();
    final messenger = ScaffoldMessenger.of(context);
    if (state.isAnonymousUser) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Crea tu cuenta gratuita en segundos para poder habilitar tu acceso Premium.',
          ),
        ),
      );
      // Tras el registro, AuthScreen vuelve aquí (no a /app ni onboarding).
      context.push('/auth?next=/premium');
      return;
    }

    setState(() => _busy = true);
    try {
      final session = await state.startPremiumCheckout();
      MetaPixel.initiateCheckout(
        value: session.amountCop,
        currency: 'COP',
        contentName: 'Premium convocatoria',
        email: state.authEmail,
        externalId: state.authUid,
      );
      final ok = await openExternalUrl(session.initPoint);
      if (!ok && mounted) {
        messenger.showSnackBar(
          const SnackBar(content: Text('No pudimos abrir Wompi.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      final detail =
          state.lastError ?? e.toString().replaceFirst('Exception: ', '');
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            detail.isNotEmpty ? detail : 'No pudimos iniciar el checkout.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _activateWithCode() async {
    final state = context.read<AppState>();
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    setState(() => _busy = true);
    final ok = await state.activatePremiumWithCode(_codeController.text);
    if (!mounted) return;
    setState(() => _busy = false);
    if (!ok) {
      messenger.showSnackBar(
        SnackBar(content: Text(state.lastError ?? 'Código inválido.')),
      );
      return;
    }
    final redeem = state.lastPromoRedeem;
    if (redeem != null && redeem.isDiscount) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            'Descuento del ${redeem.discountPercent}% aplicado. '
            'Ahora paga con Wompi el precio rebajado.',
          ),
        ),
      );
      return;
    }
    final code = _codeController.text.trim();
    GoogleAdsTag.purchase(
      value: 1.0,
      currency: 'COP',
      transactionId: code.isEmpty ? null : 'promo-$code',
    );
    messenger.showSnackBar(
      const SnackBar(content: Text('Premium activado con código.')),
    );
    router.go('/app');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final isDark = theme.brightness == Brightness.dark;
    final footerStyle = theme.textTheme.labelSmall?.copyWith(
      color: isDark
          ? AppColors.darkTextSecondary.withValues(alpha: 0.75)
          : AppColors.textMuted.withValues(alpha: 0.85),
    );

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 640),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 12, 22, 28),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/app');
                        }
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                  Text(
                    'Premium por convocatoria',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'En Gratis entrenas todos los días con límites claros. '
                    'Premium quita los topes y abre casos, especialidad y simulacros libres.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 12),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: AppColors.mist,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: theme.colorScheme.outline),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppConfig.premiumBillingLabel,
                          style: theme.textTheme.titleSmall,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          AppConfig.premiumBillingDetail,
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 22),
                  _PlanCard(
                    title: 'Gratis',
                    price: r'$0',
                    billingNote: 'Sin pago',
                    items: state.isPaidCohort
                        ? const [
                            'Reto diario de 5 preguntas (todos los días)',
                            '1 sesión de práctica al día',
                            'Diagnóstico inicial gratis',
                            'Preguntas cortas y tu progreso',
                          ]
                        : const [
                            'Reto diario de 5 preguntas (todos los días)',
                            '1 sesión de práctica al día',
                            '1 simulacro corto al mes',
                            'Preguntas cortas y tu progreso',
                          ],
                    highlighted: false,
                  ),
                  const SizedBox(height: 12),
                  // 1. Tarjeta de Plan Premium
                  _PlanCard(
                    title: 'Premium',
                    price: state.welcomeOfferActive
                        ? AppConfig.formatCop(state.displayedPremiumPriceCop)
                        : AppConfig.premiumPriceLabel,
                    billingNote: state.welcomeOfferActive
                        ? 'Bienvenida 24 h · lista ${AppConfig.premiumPriceLabel}'
                        : AppConfig.premiumBillingLabel,
                    items: const [
                      'Práctica ilimitada con explicaciones',
                      'Simulacros ilimitados + mapa de calor',
                      'Casos de aula y práctica por especialidad',
                      'Drill cronometrado en el plan (cerca del examen)',
                    ],
                    highlighted: true,
                  ),
                  const SizedBox(height: 22),
                  if (state.profile.isPremium)
                    FilledButton(
                      onPressed: () => context.go('/app'),
                      child: const Text(
                        'Ya eres Premium · Continuar entrenando',
                      ),
                    )
                  else ...[
                    if (state.welcomeOfferActive) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.45),
                          ),
                        ),
                        child: Text(
                          'Oferta de bienvenida de campaña: '
                          '${AppConfig.formatCop(state.displayedPremiumPriceCop)} '
                          'en lugar de ${AppConfig.premiumPriceLabel}. '
                          'El reloj no se reinicia; al vencer queda el precio de lista.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ] else if (state.pendingDiscountPercent != null &&
                        state.pendingDiscountPercent! > 0) ...[
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.gold.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(
                            color: AppColors.gold.withValues(alpha: 0.45),
                          ),
                        ),
                        child: Text(
                          'Código ${state.pendingDiscountCode ?? ''} · '
                          '${state.pendingDiscountPercent}% de descuento listo. '
                          'Al pagar con Wompi se aplica el precio rebajado.',
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),
                      const SizedBox(height: 12),
                    ],
                    // 2. CTA de pago + señales de confianza
                    FilledButton(
                      style: AppButtonStyles.premiumCheckout(
                        textStyle: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.ink,
                        ),
                      ),
                      onPressed: _busy ? null : _openWompiCheckout,
                      child: Text(
                        _busy
                            ? 'Preparando el pago…'
                            : 'Adquirir Premium · ${AppConfig.formatCop(state.displayedPremiumPriceCop)}',
                      ),
                    ),
                    const SizedBox(height: 12),
                    _CheckoutTrustRow(isDark: isDark),
                    const SizedBox(height: 6),
                    Text(
                      'Te redirigimos a Wompi para pagar. Sin renovación automática.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : AppColors.textMuted,
                      ),
                    ),
                    const SizedBox(height: 28),
                    // 3. Código promocional + botón fantasma
                    Text(
                      '¿Tienes código de acceso?',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _codeController,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'Código Premium',
                        hintText: 'Tu código',
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: _busy ? null : _activateWithCode,
                      child: const Text('Activar con código'),
                    ),
                    const SizedBox(height: 20),
                    // 4. Divisor
                    Divider(
                      color: (isDark ? AppColors.darkStroke : AppColors.stroke)
                          .withValues(alpha: 0.7),
                    ),
                    const SizedBox(height: 16),
                    // 5. Footer legal / explicativo
                    Text(
                      'Pago único. No se renueva solo cada mes. '
                      'Premium en tu cuenta: hasta ${AppConfig.maxPremiumDevices} dispositivos. '
                      'No compartas el acceso: el progreso, la racha y el plan se arman con tu forma de aprender.',
                      style: footerStyle,
                    ),
                    const SizedBox(height: 10),
                    const LegalFooterLinks(
                      compact: true,
                      prefix: 'Al pagar aceptas',
                    ),
                    if (AdminConfig.isAdminEmail(state.authEmail)) ...[
                      const SizedBox(height: 18),
                      OutlinedButton.icon(
                        onPressed: () => context.push('/admin/promos'),
                        icon: const Icon(Icons.admin_panel_settings_outlined),
                        label: const Text('Panel de códigos (admin)'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () => context.push('/admin/noticias'),
                        icon: const Icon(Icons.campaign_outlined),
                        label: const Text('Panel de noticias (admin)'),
                      ),
                      const SizedBox(height: 10),
                      OutlinedButton.icon(
                        onPressed: () => context.push('/admin/estudio-reels'),
                        icon: const Icon(Icons.videocam_outlined),
                        label: const Text('Estudio Reels / OBS (admin)'),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Fila compacta de confianza bajo el CTA de pago.
class _CheckoutTrustRow extends StatelessWidget {
  const _CheckoutTrustRow({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = isDark
        ? AppColors.darkTextSecondary
        : AppColors.textSecondary;
    final style = theme.textTheme.labelMedium?.copyWith(color: color);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.lock_outline_rounded, size: 16, color: color),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            'Pago único · Seguro con Wompi',
            textAlign: TextAlign.center,
            style: style,
          ),
        ),
        const SizedBox(width: 10),
        Icon(Icons.verified_user_outlined, size: 16, color: color),
        const SizedBox(width: 6),
        Icon(Icons.credit_card_outlined, size: 16, color: color),
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.title,
    required this.price,
    required this.items,
    required this.highlighted,
    this.billingNote,
  });

  final String title;
  final String price;
  final List<String> items;
  final bool highlighted;
  final String? billingNote;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: highlighted ? AppColors.ink : theme.cardTheme.color,
        border: Border.all(
          color: highlighted ? AppColors.gold : theme.colorScheme.outline,
          width: highlighted ? 1.6 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: theme.textTheme.titleLarge?.copyWith(
              color: highlighted ? AppColors.gold : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            price,
            style: theme.textTheme.titleSmall?.copyWith(
              color: highlighted ? AppColors.white : null,
            ),
          ),
          if (billingNote != null) ...[
            const SizedBox(height: 4),
            Text(
              billingNote!,
              style: theme.textTheme.labelMedium?.copyWith(
                color: highlighted ? AppColors.seafoam : AppColors.textMuted,
              ),
            ),
          ],
          const SizedBox(height: 12),
          ...items.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 18,
                    color: highlighted ? AppColors.seafoam : AppColors.canopy,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      item,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: highlighted
                            ? AppColors.white.withValues(alpha: 0.9)
                            : null,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
