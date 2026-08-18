import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../services/pwa_install_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../utils/paid_traffic.dart';
import 'account_entry_button.dart';
import 'brand_mark.dart';

/// Header de marketing para la landing (escritorio).
class LandingHeader extends StatelessWidget {
  const LandingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final pwa = context.watch<PwaInstallService>();
    final isDark = theme.brightness == Brightness.dark;

    return DecoratedBox(
      decoration: BoxDecoration(
        color: (isDark ? AppColors.darkBg : AppColors.parchment).withValues(
          alpha: 0.92,
        ),
        border: Border(
          bottom: BorderSide(
            color: isDark ? AppColors.darkStroke : AppColors.stroke,
          ),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: LayoutBreakpoints.isWide(context) ? 48 : 32,
            vertical: 14,
          ),
          child: Row(
            children: [
              const Expanded(child: BrandMark(compact: true)),
              TextButton(
                onPressed: () => context.go('/auth'),
                child: const Text('Iniciar sesión'),
              ),
              if (!PaidTraffic.isPaid) ...[
                const SizedBox(width: 8),
                OutlinedButton(
                  onPressed: () => context.go('/onboarding'),
                  child: const Text('Invitado'),
                ),
              ],
              const SizedBox(width: 8),
              FilledButton(
                onPressed: () => context.go('/auth'),
                child: const Text('Comenzar'),
              ),
              if (pwa.canInstall && !PaidTraffic.isPaid) ...[
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Instalar app',
                  onPressed: () async {
                    await pwa.promptInstall();
                  },
                  icon: const Icon(Icons.download_for_offline_outlined),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

/// Barra superior del hub autenticado (escritorio).
class AppDesktopTopBar extends StatelessWidget {
  const AppDesktopTopBar({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final isDark = theme.brightness == Brightness.dark;

    return Material(
      color: isDark ? AppColors.darkSurface : AppColors.white,
      elevation: 0,
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isDark ? AppColors.darkStroke : AppColors.stroke,
            ),
          ),
        ),
        child: Row(
          children: [
            Text(
              'Tu espacio de entrenamiento',
              style: theme.textTheme.titleMedium,
            ),
            const Spacer(),
            if (!state.isAnonymousUser && state.authEmail != null)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Text(state.authEmail!, style: theme.textTheme.bodySmall),
              ),
            const AccountEntryButton(),
            IconButton(
              tooltip: 'Modo oscuro',
              onPressed: () => state.toggleDarkMode(),
              icon: Icon(
                isDark ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
