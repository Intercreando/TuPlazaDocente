import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../screens/admin_news_screen.dart';
import '../screens/admin_promo_screen.dart';
import '../screens/app_shell.dart';
import '../screens/auth_screen.dart';
import '../screens/cases_screen.dart';
import '../screens/exam_screen.dart';
import '../screens/home_screen.dart';
import '../screens/landing_screen.dart';
import '../screens/legal_document_screen.dart';
import '../screens/news_detail_screen.dart';
import '../screens/news_screen.dart';
import '../screens/onboarding_screen.dart';
import '../screens/plan_screen.dart';
import '../screens/practice_screen.dart';
import '../screens/premium_screen.dart';
import '../screens/radar_screen.dart';
import '../screens/results_screen.dart';
import '../screens/speed_battle_screen.dart';
import '../state/app_state.dart';

/// Configuración de rutas de la PWA.
GoRouter createAppRouter(AppState appState) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: appState,
    redirect: (context, state) {
      if (!appState.ready) return null;
      final loc = state.matchedLocation;
      final onboarded = appState.profile.onboardingComplete;

      const publicPaths = {
        '/',
        '/onboarding',
        '/auth',
        '/practice',
        '/results',
        '/premium',
        '/admin/promos',
        '/legal/terms',
        '/legal/privacy',
      };

      if (!onboarded &&
          !publicPaths.contains(loc) &&
          !loc.startsWith('/practice') &&
          !loc.startsWith('/premium') &&
          !loc.startsWith('/admin') &&
          !loc.startsWith('/legal') &&
          !loc.startsWith('/noticias')) {
        return '/';
      }

      final editingProfile = loc == '/onboarding' &&
          state.uri.queryParameters['edit'] == '1';
      if (onboarded && loc == '/') return '/app';
      if (onboarded && loc == '/onboarding' && !editingProfile) {
        return '/app';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const LandingScreen(),
      ),
      GoRoute(
        path: '/auth',
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) {
          final editing = state.uri.queryParameters['edit'] == '1';
          return OnboardingScreen(editing: editing);
        },
      ),
      GoRoute(
        path: '/practice',
        builder: (context, state) => const PracticeScreen(),
      ),
      GoRoute(
        path: '/exam',
        builder: (context, state) => const ExamScreen(),
      ),
      GoRoute(
        path: '/speed',
        builder: (context, state) => const SpeedBattleScreen(),
      ),
      GoRoute(
        path: '/results',
        builder: (context, state) => const ResultsScreen(),
      ),
      GoRoute(
        path: '/premium',
        builder: (context, state) => const PremiumScreen(),
      ),
      GoRoute(
        path: '/admin/promos',
        builder: (context, state) => const AdminPromoScreen(),
      ),
      GoRoute(
        path: '/admin/noticias',
        builder: (context, state) => const AdminNewsScreen(),
      ),
      GoRoute(
        path: '/noticias/:id',
        builder: (context, state) => NewsDetailScreen(
          id: state.pathParameters['id'] ?? '',
        ),
      ),
      GoRoute(
        path: '/legal/terms',
        builder: (context, state) => const LegalDocumentScreen(
          kind: LegalDocumentKind.terms,
        ),
      ),
      GoRoute(
        path: '/legal/privacy',
        builder: (context, state) => const LegalDocumentScreen(
          kind: LegalDocumentKind.privacy,
        ),
      ),
      GoRoute(
        path: '/cases',
        builder: (context, state) => const CasesScreen(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomeScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/plan',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PlanScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/radar',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: RadarScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/premium',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PremiumScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/app/noticias',
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: NewsScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'No encontramos esa pantalla.',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                FilledButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Ir al inicio'),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

/// Helper para leer AppState en redirects si se necesita fuera.
AppState readAppState(BuildContext context) => context.read<AppState>();
