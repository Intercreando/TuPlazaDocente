import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../utils/guest_capture.dart';
import '../utils/meta_pixel.dart';
import '../utils/open_external_url.dart';
import 'premium_nav.dart';

/// Abre Wompi. Si es invitado, captura el correo antes.
Future<void> openWompiCheckout(BuildContext context) async {
  final state = context.read<AppState>();
  final messenger = ScaffoldMessenger.of(context);

  if (state.isAnonymousUser) {
    final captured = await showGuestEmailCapture(
      context,
      lockMessage:
          'Para habilitar Premium y guardar tu progreso en la nube de forma '
          'segura, ingresa tu correo electrónico.',
    );
    if (!context.mounted) return;
    if (captured != GuestCaptureOutcome.registered) {
      if (captured == GuestCaptureOutcome.needsLogin ||
          captured == GuestCaptureOutcome.goToLogin) {
        if (captured == GuestCaptureOutcome.needsLogin) {
          final again = context.read<AppState>();
          messenger.showSnackBar(
            SnackBar(
              content: Text(
                again.lastError ??
                    'Ese correo ya tiene cuenta. Entra con Google o con tu contraseña.',
              ),
            ),
          );
        }
        openExistingAccountLogin(context);
      }
      return;
    }
  }

  try {
    final session = await state.startPremiumCheckout();
    MetaPixel.initiateCheckout(
      value: session.amountCop,
      currency: 'COP',
      contentName: 'Premium convocatoria',
      email: state.authEmail,
      externalId: state.authUid,
    );
    final ok = await openExternalUrl(session.initPoint);
    if (!ok && context.mounted) {
      messenger.showSnackBar(
        const SnackBar(content: Text('No pudimos abrir Wompi.')),
      );
    }
  } catch (e) {
    if (!context.mounted) return;
    final detail =
        state.lastError ?? e.toString().replaceFirst('Exception: ', '');
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          detail.isNotEmpty ? detail : 'No pudimos iniciar el checkout.',
        ),
      ),
    );
  }
}
