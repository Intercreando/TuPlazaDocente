import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_colors.dart';
import '../theme/layout_breakpoints.dart';
import '../widgets/premium_chrome.dart';

/// Shell: rail + top bar en escritorio; bottom nav en móvil.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final desktop = LayoutBreakpoints.isDesktop(context);

    if (!desktop) {
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _onTap,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home_rounded),
              label: 'Inicio',
            ),
            NavigationDestination(
              icon: Icon(Icons.route_outlined),
              selectedIcon: Icon(Icons.route),
              label: 'Plan',
            ),
            NavigationDestination(
              icon: Icon(Icons.radar_outlined),
              selectedIcon: Icon(Icons.radar),
              label: 'Radar',
            ),
            NavigationDestination(
              icon: Icon(Icons.workspace_premium_outlined),
              selectedIcon: Icon(Icons.workspace_premium),
              label: 'Premium',
            ),
          ],
        ),
      );
    }

    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _onTap,
            extended: LayoutBreakpoints.isWide(context),
            backgroundColor: isDark ? AppColors.darkSurface : AppColors.white,
            indicatorColor: AppColors.canopy.withValues(alpha: 0.18),
            selectedIconTheme: const IconThemeData(color: AppColors.canopy),
            unselectedIconTheme: IconThemeData(
              color: isDark ? AppColors.darkTextSecondary : AppColors.textMuted,
            ),
            labelType: LayoutBreakpoints.isWide(context)
                ? NavigationRailLabelType.none
                : NavigationRailLabelType.all,
            leading: Padding(
              padding: const EdgeInsets.only(top: 12, bottom: 20),
              child: IconButton(
                tooltip: 'TuPlazaDocente',
                onPressed: () => context.go('/app'),
                icon: const Icon(Icons.local_fire_department_rounded,
                    color: AppColors.gold),
              ),
            ),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_rounded),
                label: Text('Inicio'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.route_outlined),
                selectedIcon: Icon(Icons.route),
                label: Text('Plan'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.radar_outlined),
                selectedIcon: Icon(Icons.radar),
                label: Text('Radar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.workspace_premium_outlined),
                selectedIcon: Icon(Icons.workspace_premium),
                label: Text('Premium'),
              ),
            ],
          ),
          VerticalDivider(
            width: 1,
            color: isDark ? AppColors.darkStroke : AppColors.stroke,
          ),
          Expanded(
            child: Column(
              children: [
                const AppDesktopTopBar(),
                Expanded(child: navigationShell),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
