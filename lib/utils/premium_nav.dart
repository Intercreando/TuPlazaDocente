import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Abre Premium. Si ya estás en el hub (`/app`), usa la pestaña para no
/// perder la barra inferior del móvil.
void openPremium(BuildContext context) {
  final path = GoRouterState.of(context).uri.path;
  if (path.startsWith('/app')) {
    context.go('/app/premium');
    return;
  }
  context.push('/premium');
}

/// Login de una cuenta que ya existe, conservando el destino de pago.
void openExistingAccountLogin(BuildContext context) {
  final path = GoRouterState.of(context).uri.path;
  final next = path.startsWith('/app') ? '/app/premium' : '/premium';
  context.push('/auth?next=$next');
}
