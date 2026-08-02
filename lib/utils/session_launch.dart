import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../state/app_state.dart';

/// Si el start falla por paywall/cupo, muestra mensaje y ofrece Premium.
bool launchSessionOrPaywall({
  required BuildContext context,
  required AppState state,
  required bool started,
  required String route,
}) {
  if (started) {
    context.push(route);
    return true;
  }
  final msg = state.lastError ?? 'Necesitas Premium para continuar.';
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      action: SnackBarAction(
        label: 'Premium',
        onPressed: () => context.push('/premium'),
      ),
    ),
  );
  return false;
}
