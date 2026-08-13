import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/layout_breakpoints.dart';
import '../widgets/app_desktop_sidebar.dart';
import '../widgets/premium_chrome.dart';

/// Shell: sidebar premium en escritorio; bottom nav en móvil.
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
    final desktop = LayoutBreakpoints.isDesktop(context);

    if (!desktop) {
      final onNews = navigationShell.currentIndex == 4;
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: onNews
            ? null
            : NavigationBar(
                selectedIndex: navigationShell.currentIndex.clamp(0, 3),
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
          AppDesktopSidebar(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: _onTap,
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
