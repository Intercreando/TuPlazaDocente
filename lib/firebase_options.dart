// Configuración pública del cliente Firebase (generada para TuPlazaDocente Web).
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Opciones por plataforma para inicializar Firebase.
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
      case TargetPlatform.iOS:
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return web;
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions no está configurado para esta plataforma.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyANYgxAcXpmB7nOk2Fi2mBxGgSc3rxhcW8',
    appId: '1:472139054798:web:aef4f94fa8e5bc7e845a9f',
    messagingSenderId: '472139054798',
    projectId: 'tuplazadocente-9334d',
    authDomain: 'tuplazadocente-9334d.firebaseapp.com',
    storageBucket: 'tuplazadocente-9334d.firebasestorage.app',
    measurementId: 'G-R8PQ3JBS6K',
  );
}
