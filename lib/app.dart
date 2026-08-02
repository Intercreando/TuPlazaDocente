import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'router/app_router.dart';
import 'services/pwa_install_service.dart';
import 'services/tts_service.dart';
import 'state/app_state.dart';
import 'theme/app_colors.dart';
import 'theme/app_theme.dart';
import 'widgets/brand_logo.dart';

/// Raíz de la aplicación TuPlazaDocente.
class TuPlazaDocenteApp extends StatefulWidget {
  const TuPlazaDocenteApp({super.key});

  @override
  State<TuPlazaDocenteApp> createState() => _TuPlazaDocenteAppState();
}

class _TuPlazaDocenteAppState extends State<TuPlazaDocenteApp> {
  late final AppState _appState;
  late final PwaInstallService _pwaInstallService;
  late final TtsService _ttsService;
  late final GoRouter _router;

  @override
  void initState() {
    super.initState();
    _appState = AppState();
    _pwaInstallService = PwaInstallService();
    _ttsService = TtsService();
    _router = createAppRouter(_appState);
    _appState.bootstrap();
  }

  @override
  void dispose() {
    _appState.dispose();
    _pwaInstallService.dispose();
    _ttsService.dispose();
    _router.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: _appState),
        ChangeNotifierProvider.value(value: _pwaInstallService),
        ChangeNotifierProvider.value(value: _ttsService),
      ],
      child: Consumer<AppState>(
        builder: (context, state, _) {
          if (!state.ready) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: AppTheme.light(),
              darkTheme: AppTheme.dark(),
              home: Scaffold(
                backgroundColor: AppColors.parchment,
                body: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const BrandLogo(size: 96),
                      const SizedBox(height: 16),
                      Text(
                        'TuPlazaDocente',
                        style: AppTheme.light().textTheme.headlineSmall,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Cargando...',
                        style: AppTheme.light().textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
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
