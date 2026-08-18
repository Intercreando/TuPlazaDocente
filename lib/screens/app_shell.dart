import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../theme/layout_breakpoints.dart';
import '../widgets/app_desktop_sidebar.dart';
import '../widgets/premium_chrome.dart';

/// Shell: sidebar premium en escritorio; bottom nav en móvil.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  /// Orden visual en móvil: Premium al final. Los índices son ramas del router.
  static const _mobileBranchOrder = [0, 1, 2, 4, 3];

  void _onTap(int branchIndex) {
    navigationShell.goBranch(
      branchIndex,
      initialLocation: branchIndex == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final desktop = LayoutBreakpoints.isDesktop(context);

    if (!desktop) {
      final visualIndex = _mobileBranchOrder.indexOf(
        navigationShell.currentIndex,
      );
      return Scaffold(
        body: navigationShell,
        bottomNavigationBar: NavigationBar(
          selectedIndex: visualIndex < 0 ? 0 : visualIndex,
          onDestinationSelected: (index) => _onTap(_mobileBranchOrder[index]),
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
              icon: Icon(Icons.insights_outlined),
              selectedIcon: Icon(Icons.insights),
              label: 'Progreso',
            ),
            NavigationDestination(
              icon: Icon(Icons.campaign_outlined),
              selectedIcon: Icon(Icons.campaign_rounded),
              label: 'Noticias',
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
