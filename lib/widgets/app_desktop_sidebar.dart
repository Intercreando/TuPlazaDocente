import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import 'brand_logo.dart';

/// Barra lateral de escritorio con estilo más premium que un NavigationRail plano.
class AppDesktopSidebar extends StatelessWidget {
  const AppDesktopSidebar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  static const double width = 248;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final state = context.watch<AppState>();

    final items = <_SidebarItemData>[
      const _SidebarItemData(
        icon: Icons.home_outlined,
        selectedIcon: Icons.home_rounded,
        label: 'Inicio',
        caption: 'Entrenar hoy',
      ),
      const _SidebarItemData(
        icon: Icons.route_outlined,
        selectedIcon: Icons.route_rounded,
        label: 'Plan',
        caption: 'Ruta al examen',
      ),
      const _SidebarItemData(
        icon: Icons.radar_outlined,
        selectedIcon: Icons.radar_rounded,
        label: 'Radar',
        caption: 'Tu progreso',
      ),
      _SidebarItemData(
        icon: Icons.workspace_premium_outlined,
        selectedIcon: Icons.workspace_premium_rounded,
        label: 'Premium',
        caption: state.profile.isPremium ? 'Activo' : 'Desbloquear',
        accent: true,
      ),
    ];

    return Material(
      color: Colors.transparent,
      child: Container(
        width: width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: isDark
                ? const [AppColors.darkElevated, AppColors.darkBg]
                : const [AppColors.ink, AppColors.inkSoft],
          ),
          border: Border(
            right: BorderSide(
              color: isDark
                  ? AppColors.darkStroke
                  : AppColors.ink.withValues(alpha: 0.35),
            ),
          ),
        ),
        child: SafeArea(
          right: false,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(14, 18, 14, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => context.go('/app'),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: const BrandLogo(size: 40),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TuPlaza',
                                style: theme.textTheme.titleSmall?.copyWith(
                                  color: AppColors.white,
                                ),
                              ),
                              Text(
                                'Docente',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: AppColors.gold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 22),
                Text(
                  'Navegación',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: AppColors.white.withValues(alpha: 0.55),
                    letterSpacing: 0.6,
                  ),
                ),
                const SizedBox(height: 10),
                for (var i = 0; i < items.length; i++) ...[
                  _SidebarNavButton(
                    data: items[i],
                    selected: selectedIndex == i,
                    onTap: () => onDestinationSelected(i),
                  ),
                  if (i < items.length - 1) const SizedBox(height: 8),
                ],
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: AppColors.gold.withValues(alpha: 0.35),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.profile.isPremium
                            ? 'Premium activo'
                            : 'Plan por convocatoria',
                        style: theme.textTheme.titleSmall?.copyWith(
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        state.profile.isPremium
                            ? 'Práctica y simulacros sin tope en esta cuenta.'
                            : 'En Gratis hay cupos. Premium abre casos y especialidad.',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppColors.white.withValues(alpha: 0.78),
                        ),
                      ),
                      if (!state.profile.isPremium) ...[
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: FilledButton(
                            style: FilledButton.styleFrom(
                              backgroundColor: AppColors.gold,
                              foregroundColor: AppColors.ink,
                            ),
                            onPressed: () => onDestinationSelected(3),
                            child: const Text('Ver Premium'),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SidebarItemData {
  const _SidebarItemData({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.caption,
    this.accent = false,
  });

  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final String caption;
  final bool accent;
}

class _SidebarNavButton extends StatelessWidget {
  const _SidebarNavButton({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _SidebarItemData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = data.accent;
    final bg = selected
        ? (accent
            ? AppColors.gold.withValues(alpha: 0.22)
            : AppColors.seafoam.withValues(alpha: 0.2))
        : AppColors.white.withValues(alpha: 0.04);
    final border = selected
        ? (accent
            ? AppColors.gold.withValues(alpha: 0.7)
            : AppColors.seafoam.withValues(alpha: 0.55))
        : AppColors.white.withValues(alpha: 0.08);
    final iconColor = selected
        ? (accent ? AppColors.gold : AppColors.seafoam)
        : AppColors.white.withValues(alpha: 0.72);
    final titleColor = selected ? AppColors.white : AppColors.white.withValues(alpha: 0.88);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: border),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.white.withValues(alpha: 0.12)
                      : AppColors.white.withValues(alpha: 0.06),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  selected ? data.selectedIcon : data.icon,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.label,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: titleColor,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      data.caption,
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.white.withValues(alpha: 0.55),
                      ),
                    ),
                  ],
                ),
              ),
              if (selected)
                Icon(
                  Icons.chevron_right_rounded,
                  color: accent ? AppColors.gold : AppColors.seafoam,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
