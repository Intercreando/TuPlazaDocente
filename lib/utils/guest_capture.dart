import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/layout_breakpoints.dart';
import '../widgets/guest_email_sheet.dart';
import 'guest_capture_outcome.dart';
import 'premium_nav.dart';

export 'guest_capture_outcome.dart';

/// Gancho de captura según el muro que chocó el invitado.
String guestCaptureHook(String lockMessage) {
  final lower = lockMessage.toLowerCase();
  if (lower.contains('caso')) {
    return 'Para acceder a los Casos del Colegio y guardar tu progreso en la '
        'nube de forma segura, ingresa tu correo electrónico.';
  }
  if (lower.contains('área') || lower.contains('area')) {
    return 'Para practicar tu área y guardar tu progreso en la nube de forma '
        'segura, ingresa tu correo electrónico.';
  }
  if (lower.contains('premium')) {
    return 'Para habilitar Premium y guardar tu progreso en la nube de forma '
        'segura, ingresa tu correo electrónico.';
  }
  return 'Para desbloquear esta práctica y guardar tu progreso en la nube de '
      'forma segura, ingresa tu correo electrónico.';
}

/// Modal para convertir invitado en cuenta.
Future<GuestCaptureOutcome> showGuestEmailCapture(
  BuildContext context, {
  required String lockMessage,
}) async {
  final state = context.read<AppState>();
  if (!state.isAnonymousUser) return GuestCaptureOutcome.registered;

  final desktop = LayoutBreakpoints.isDesktop(context);
  if (!context.mounted) return GuestCaptureOutcome.dismissed;
  final captured = desktop
      ? await showDialog<GuestCaptureOutcome>(
          context: context,
          barrierDismissible: false,
          builder: (ctx) => Dialog(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 460),
              child: SingleChildScrollView(
                child: GuestEmailSheet(hook: guestCaptureHook(lockMessage)),
              ),
            ),
          ),
        )
      : await showModalBottomSheet<GuestCaptureOutcome>(
          context: context,
          isScrollControlled: true,
          isDismissible: false,
          enableDrag: false,
          builder: (ctx) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.viewInsetsOf(ctx).bottom,
            ),
            child: GuestEmailSheet(hook: guestCaptureHook(lockMessage)),
          ),
        );
  return captured ?? GuestCaptureOutcome.dismissed;
}

/// Tras capturar el correo, abre Premium (pago / planes).
Future<void> captureGuestThenOpenPremium(
  BuildContext context, {
  required String lockMessage,
}) async {
  final outcome = await showGuestEmailCapture(
    context,
    lockMessage: lockMessage,
  );
  if (!context.mounted) return;
  switch (outcome) {
    case GuestCaptureOutcome.registered:
      openPremium(context);
    case GuestCaptureOutcome.needsLogin:
      final err = context.read<AppState>().lastError;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            err ??
                'Ese correo ya tiene cuenta. Entra con Google o con tu contraseña.',
          ),
        ),
      );
      openExistingAccountLogin(context);
    case GuestCaptureOutcome.goToLogin:
      openExistingAccountLogin(context);
    case GuestCaptureOutcome.dismissed:
      break;
  }
}
