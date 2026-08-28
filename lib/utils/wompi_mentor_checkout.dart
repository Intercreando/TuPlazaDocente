import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/app_config.dart';
import '../state/app_state.dart';
import '../utils/guest_capture.dart';
import '../utils/meta_pixel.dart';
import '../utils/open_external_url.dart';
import '../utils/premium_nav.dart';

/// Abre Wompi del pase Mentor IA ($19.900 / 30 días). No usa el checkout Premium.
Future<void> openMentorPassCheckout(BuildContext context) async {
  final state = context.read<AppState>();
  final messenger = ScaffoldMessenger.of(context);

  if (state.isAnonymousUser) {
    final captured = await showGuestEmailCapture(
      context,
      lockMessage:
          'Para activar el Mentor IA y guardar tu progreso en la nube, '
          'ingresa tu correo electrónico.',
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

  if (!state.profile.isPremium) {
    if (!context.mounted) return;
    messenger.showSnackBar(
      const SnackBar(content: Text('El Mentor IA es un extra de Premium.')),
    );
    openPremium(context);
    return;
  }

  try {
    final session = await state.startMentorPassCheckout();
    MetaPixel.initiateCheckout(
      value: session.amountCop,
      currency: 'COP',
      contentName: 'Mentor IA 30 días',
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
          detail.isNotEmpty
              ? detail
              : 'No pudimos iniciar el pase de ${AppConfig.mentorPassPriceLabel}.',
        ),
      ),
    );
  }
}
