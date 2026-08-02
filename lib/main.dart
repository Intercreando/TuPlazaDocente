import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Importante: no usar .timeout() sobre initializeApp (cancela el canal pigeon
  // y deja la app en blanco al tocar FirebaseAuth/Firestore.instance).
  await _initFirebase();

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
    return;
  } catch (e) {
    debugPrint('Firebase init: $e');
  }

  // Reintento corto: en web el canal a veces no está listo al primer tick.
  try {
    await Future<void>.delayed(const Duration(milliseconds: 120));
    if (Firebase.apps.isNotEmpty) return;
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase init (reintento): $e');
  }
}
