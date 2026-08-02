import 'package:cloud_firestore_web/cloud_firestore_web.dart';
import 'package:cloud_functions_web/cloud_functions_web.dart';
import 'package:firebase_auth_web/firebase_auth_web.dart';
import 'package:firebase_core_web/firebase_core_web.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

/// Fuerza el platform implementation web de FlutterFire.
///
/// En release, a veces el build usa el MethodChannel/pigeon (móvil) y
/// `Firebase.initializeApp` falla con channel-error. Registrar aquí evita
/// esa ruta y deja Auth/Firestore/Functions operativos.
void ensureFirebaseWebPlugins() {
  final registrar = webPluginRegistrar;
  FirebaseCoreWeb.registerWith(registrar);
  FirebaseAuthWeb.registerWith(registrar);
  FirebaseFirestoreWeb.registerWith(registrar);
  FirebaseFunctionsWeb.registerWith(registrar);
}
