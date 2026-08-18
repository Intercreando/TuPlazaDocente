import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../config/paid_funnel.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/premium_nav.dart';

/// Banner no bloqueante: oferta 24 h real para cuentas de pauta.
class WelcomeOfferBanner extends StatefulWidget {
  const WelcomeOfferBanner({super.key});

  @override
  State<WelcomeOfferBanner> createState() => _WelcomeOfferBannerState();
}

class _WelcomeOfferBannerState extends State<WelcomeOfferBanner> {
  Timer? _ticker;

  @override
  void initState() {
    super.initState();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _ticker?.cancel();
    super.dispose();
  }

  String _clock(Duration left) {
    final total = left.inSeconds;
    if (total <= 0) return '00:00:00';
    final h = (total ~/ 3600).toString().padLeft(2, '0');
    final m = ((total % 3600) ~/ 60).toString().padLeft(2, '0');
    final s = (total % 60).toString().padLeft(2, '0');
    return '$h:$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    if (!PaidFunnel.welcomeOfferActive(state.profile)) {
      return const SizedBox.shrink();
    }
    final theme = Theme.of(context);
    final left = PaidFunnel.welcomeRemaining(state.profile);
    final price = AppConfig.formatCop(state.displayedPremiumPriceCop);

    return Material(
      color: AppColors.gold.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: () => openPremium(context),
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              const Icon(Icons.schedule_rounded, color: AppColors.goldDeep),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Bienvenida de campaña: Premium a $price',
                      style: theme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Precio de lista ${AppConfig.premiumPriceLabel}. '
                      'Quedan ${_clock(left)}. Si se vence, queda el precio de lista.',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
