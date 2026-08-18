import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../state/app_state.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';
import '../utils/premium_nav.dart';

/// Invitación Premium del home: tarjeta oscura con oro, no un ListTile plano.
class HomePremiumInvite extends StatelessWidget {
  const HomePremiumInvite({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final offer = state.welcomeOfferActive;
    final price = offer
        ? AppConfig.formatCop(state.displayedPremiumPriceCop)
        : AppConfig.premiumPriceLabel;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => openPremium(context),
        borderRadius: BorderRadius.circular(24),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: const LinearGradient(
              colors: [AppColors.ink, AppColors.inkSoft],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: AppColors.gold, width: 1.6),
            boxShadow: [
              BoxShadow(
                color: AppColors.gold.withValues(alpha: 0.28),
                blurRadius: 22,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(22, 20, 22, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.gold.withValues(alpha: 0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Icon(
                        Icons.workspace_premium_rounded,
                        color: AppColors.gold,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Premium',
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                Text(
                  'Desbloquea todo el entrenamiento',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  offer
                      ? 'Hoy puedes entrar con precio de bienvenida. '
                            'Pago único por convocatoria, sin cuotas.'
                      : 'Práctica y simulacros sin tope, casos del colegio y tu área. '
                            'Un solo pago por convocatoria.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.88),
                  ),
                ),
                const SizedBox(height: 14),
                const _PremiumPerk(
                  text: 'Practicar sin reloj, las veces que quieras',
                ),
                const _PremiumPerk(
                  text: 'Simulacro con tiempo, sin cupo mensual',
                ),
                const _PremiumPerk(
                  text: 'Casos del colegio y preguntas de tu área',
                ),
                const SizedBox(height: 16),
                Text(
                  price,
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: AppColors.gold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  offer
                      ? 'Bienvenida · lista ${AppConfig.premiumPriceLabel}'
                      : AppConfig.premiumBillingLabel,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.78),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  style: AppButtonStyles.filledOnBrand(completed: false),
                  onPressed: () => openPremium(context),
                  icon: const Icon(Icons.lock_open_rounded),
                  label: const Text('Desbloquear Premium'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PremiumPerk extends StatelessWidget {
  const _PremiumPerk({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.check_circle_rounded, color: AppColors.gold),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
