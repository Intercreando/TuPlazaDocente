import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../config/seo_landing_routes.dart';
import '../models/seo_landing_page.dart';
import '../theme/app_button_styles.dart';
import '../theme/app_colors.dart';

/// Gancho de registro tras el cebo público.
class SeoLandingCta extends StatelessWidget {
  const SeoLandingCta({super.key, required this.page, required this.loggedIn});

  final SeoLandingPage page;
  final bool loggedIn;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.ink,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 26, 24, 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              page.ctaTitle,
              style: theme.textTheme.headlineSmall?.copyWith(
                color: AppColors.gold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              page.ctaBody,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: AppColors.white.withValues(alpha: 0.9),
              ),
            ),
            const SizedBox(height: 18),
            FilledButton(
              style: AppButtonStyles.premiumCheckout(
                textStyle: theme.textTheme.titleSmall?.copyWith(
                  color: AppColors.ink,
                ),
              ),
              onPressed: () {
                if (loggedIn) {
                  context.go('/app');
                  return;
                }
                context.go(SeoLandingRoutes.authCta(source: page.source));
              },
              child: Text(
                loggedIn ? 'Entrar al simulador' : page.ctaLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
