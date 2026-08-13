import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'bootstrap/firebase_web_plugins.dart';
import 'firebase_options.dart';
import 'theme/app_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    ensureFirebaseWebPlugins();
  }

  await Future.wait<void>([
    _initFirebase(),
    prepareAppFonts(),
  ]);

  try {
    await SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  } catch (_) {
    // En web algunas restricciones de orientación no aplican.
  }

  runApp(const TuPlazaDocenteApp());
}

Future<void> _initFirebase() async {
  try {
    if (Firebase.apps.isNotEmpty) return;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase listo (${Firebase.apps.length} app(s)).');
    return;
  } catch (e) {
    debugPrint('Firebase init: $e');
  }

  try {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (Firebase.apps.isNotEmpty) return;
    if (kIsWeb) {
      ensureFirebaseWebPlugins();
    }
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    debugPrint('Firebase listo tras reintento.');
  } catch (e) {
    debugPrint('Firebase init (reintento): $e');
  }
}
