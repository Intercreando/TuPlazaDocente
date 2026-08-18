import 'package:flutter/material.dart';

import 'premium_nav.dart';

/// Avisos temporales de la app (auto-cierran; no tapan la UI en PC/móvil).
abstract final class AppSnackbars {
  /// Duración estándar de avisos con acción (p. ej. Premium).
  static const Duration withAction = Duration(seconds: 4);

  /// Duración de avisos informativos sin acción.
  static const Duration info = Duration(seconds: 3);

  /// Muestra un aviso que se cierra solo (~4 s) y con botón X.
  ///
  /// No usa [SnackBarAction]: en Flutter Web/desktop ese action puede dejar
  /// el aviso abierto indefinidamente aunque se pase [duration].
  static void show(
    BuildContext context, {
    required String message,
    String? actionLabel,
    VoidCallback? onAction,
    Duration? duration,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();

    final hasAction = actionLabel != null && onAction != null;
    final wait = duration ?? (hasAction ? withAction : info);

    late final ScaffoldFeatureController<SnackBar, SnackBarClosedReason>
        controller;

    controller = messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        dismissDirection: DismissDirection.horizontal,
        duration: wait,
        // X nativa de Material 3 para cerrar a mano.
        showCloseIcon: true,
        closeIconColor: Colors.white,
        content: Row(
          children: [
            Expanded(
              child: Text(message),
            ),
            if (hasAction) ...[
              const SizedBox(width: 8),
              TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                onPressed: () {
                  controller.close();
                  onAction();
                },
                child: Text(actionLabel),
              ),
            ],
          ],
        ),
      ),
    );

    // Cierre forzado: respaldo si el motor web ignora [duration].
    Future<void>.delayed(wait, () {
      try {
        controller.close();
      } catch (_) {
        // Ya cerrado por el usuario o por el propio SnackBar.
      }
    });
  }

  /// Aviso de función bloqueada + acceso rápido a Premium.
  static void premiumLocked(BuildContext context, String message) {
    show(
      context,
      message: message,
      actionLabel: 'Premium',
      onAction: () => openPremium(context),
    );
  }
}
