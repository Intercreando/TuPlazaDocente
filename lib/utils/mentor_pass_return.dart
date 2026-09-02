import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import 'app_snackbars.dart';
import 'google_ads_tag.dart';
import 'meta_pixel.dart';

/// Tras Wompi (`/tutor?mentorPass=pending`): sincroniza el pase y registra Purchase.
Future<void> handleMentorPassReturn(
  BuildContext context, {
  String? status,
}) async {
  final declined = _isDeclined(status);
  if (declined) {
    if (!context.mounted) return;
    AppSnackbars.show(
      context,
      message: 'El pago del pase no se completó. Puedes intentar de nuevo.',
    );
    return;
  }

  final state = context.read<AppState>();
  await state.refreshPremiumFromCloud();
  if (!context.mounted) return;

  if (!_looksApproved(status) && !state.profile.hasMentorPass) {
    return;
  }

  if (!state.profile.hasMentorPass) {
    await Future<void>.delayed(const Duration(seconds: 3));
    if (!context.mounted) return;
    await state.refreshPremiumFromCloud();
  }

  if (!context.mounted) return;
  if (state.profile.hasMentorPass) {
    final purchase = await state.takeMentorCheckoutPurchaseValue();
    MetaPixel.purchase(
      value: purchase.value,
      currency: 'COP',
      contentName: 'Mentor IA 30 días',
      email: state.authEmail,
      externalId: state.authUid,
    );
    GoogleAdsTag.purchase(
      value: purchase.value,
      currency: 'COP',
      transactionId: purchase.transactionId,
      email: state.authEmail,
    );
  }

  if (!context.mounted) return;
  AppSnackbars.show(
    context,
    message: state.profile.hasMentorPass
        ? 'Pase del Mentor IA activo por 30 días. Renovación manual, sin débito.'
        : 'Pago recibido. Si el pase aún no aparece, espera unos segundos y recarga.',
  );
}

bool _looksApproved(String? status) {
  if (status == null || status == 'pending') return true;
  final upper = status.toUpperCase();
  return upper == 'APPROVED' || upper == 'SUCCESS' || upper == 'PENDING';
}

bool _isDeclined(String? status) {
  if (status == null) return false;
  final upper = status.toUpperCase();
  return upper == 'DECLINED' ||
      upper == 'VOIDED' ||
      upper == 'ERROR' ||
      upper == 'FAILURE';
}
