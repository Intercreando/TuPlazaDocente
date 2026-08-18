import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';

/// Acceso a la cuenta con texto visible (docentes 45+: no solo el icono).
class AccountEntryButton extends StatelessWidget {
  const AccountEntryButton({super.key, this.compact = false});

  final bool compact;

  @override
  Widget build(BuildContext context) {
    final state = context.watch<AppState>();
    final anonymous = state.isAnonymousUser;

    return TextButton.icon(
      onPressed: () => context.push('/auth'),
      style: compact
          ? TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            )
          : null,
      icon: Icon(
        anonymous ? Icons.person_add_alt_1_outlined : Icons.person_outline,
      ),
      label: Text(
        compact ? 'Cuenta' : (anonymous ? 'Guardar cuenta' : 'Mi cuenta'),
        overflow: TextOverflow.ellipsis,
        maxLines: 1,
      ),
    );
  }
}
