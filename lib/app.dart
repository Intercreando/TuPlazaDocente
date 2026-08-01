import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'services/pwa_install_service.dart';
import 'state/app_state.dart';
import 'theme/app_theme.dart';

/// Raíz de la aplicación TuPlazaDocente.
class TuPlazaDocenteApp extends StatefulWidget {
  const TuPlazaDocenteApp({super.key});

  @override
  State<TuPlazaDocenteApp> createState() => _TuPlazaDocenteAppState();
}

class _TuPlazaDocenteAppState extends State<TuPlazaDocenteApp> {
  late final AppState _appState;
  late final PwaInstallService _pwaInstallService;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _pwaInstallService = PwaInstallService();
    _router = createAppRouter(_appState);
    _appState.bootstrap();
  }

  @override
  void dispose() {
    _appState.dispose();
    _pwaInstallService.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _appState),
        ChangeNotifierProvider.value(value: _pwaInstallService),
      ],
      child: Consumer<AppState>(
        builder: (context, state, _) {
          if (!state.ready) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              home: const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              ),
            );
          }

          return MaterialApp.router(
            title: 'TuPlazaDocente',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light(),
            darkTheme: AppTheme.dark(),
            themeMode: state.profile.darkMode ? ThemeMode.dark : ThemeMode.light,
            routerConfig: _router,
          );
        },
      ),
    );
  }
}
