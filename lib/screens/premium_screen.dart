import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
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

      Future<void> tryTrackPurchase() async {
        if (purchaseTracked || wasPremium || !state.profile.isPremium) {
          return;
        }
        MetaPixel.purchase(
          value: AppConfig.premiumPriceCop,
          currency: 'COP',
          contentName: 'Premium convocatoria',
        );
        purchaseTracked = true;
      }

      await state.refreshPremiumFromCloud();
      if (!mounted) return;
      await tryTrackPurchase();

      // Webhook puede tardar unos segundos tras el redirect de Wompi.
      if (status == 'success' && !state.profile.isPremium) {
        await Future<void>.delayed(const Duration(seconds: 3));
        if (!mounted) return;
        await state.refreshPremiumFromCloud();
        await tryTrackPurchase();
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
            'Para pagar Premium, guarda tu cuenta con Google o correo primero.',
          ),
        ),
      );
      context.push('/auth');
      return;
    }

    setState(() => _busy = true);
    try {
      final url = await state.startPremiumCheckout();
      final ok = await openExternalUrl(url);
      if (!ok && mounted) {
        messenger.showSnackBar(
          const SnackBar(content: Text('No pudimos abrir Wompi.')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      final detail = state.lastError ??
          e.toString().replaceFirst('Exception: ', '');
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            detail.isNotEmpty
                ? detail
                : 'No pudimos iniciar el checkout.',
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final isDark = theme.brightness == Brightness.dark;

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
                    items: const [
                      'Reto diario de 5 preguntas (todos los días)',
                      '1 sesión de práctica al día',
                      '1 simulacro corto al mes',
                      'Reto rápido y radar básico',
                    ],
                    highlighted: false,
                  ),
                  const SizedBox(height: 12),
                  _PlanCard(
                    title: 'Premium',
                    price: AppConfig.premiumPriceLabel,
                    billingNote: AppConfig.premiumBillingLabel,
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
                      child: const Text('Ya eres Premium · Continuar entrenando'),
                    )
                  else ...[
                    FilledButton.icon(
                      onPressed: _busy ? null : _openWompiCheckout,
                      icon: const Icon(Icons.payments_outlined),
                      label: Text(
                        _busy
                            ? 'Preparando el pago…'
                            : 'Pagar una vez · Wompi',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Pago único. No se renueva solo cada mes. '
                      'Premium en tu cuenta: hasta ${AppConfig.maxPremiumDevices} dispositivos. '
                      'No compartas el acceso: el radar, la racha y el plan se arman con tu forma de aprender.',
                      style: theme.textTheme.bodySmall,
                    ),
                    const SizedBox(height: 10),
                    const LegalFooterLinks(),
                    const SizedBox(height: 12),
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
                      onPressed: _busy
                          ? null
                          : () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final router = GoRouter.of(context);
                              setState(() => _busy = true);
                              final ok = await state.activatePremiumWithCode(
                                _codeController.text,
                              );
                              if (!mounted) return;
                              setState(() => _busy = false);
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    ok
                                        ? 'Premium activado con código.'
                                        : state.lastError ?? 'Código inválido.',
                                  ),
                                ),
                              );
                              if (ok) router.go('/app');
                            },
                      child: const Text('Activar con código'),
                    ),
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
                color: highlighted
                    ? AppColors.seafoam
                    : AppColors.textMuted,
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
