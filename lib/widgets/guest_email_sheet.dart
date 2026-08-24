import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/guest_capture_outcome.dart';

/// Hoja de captura: correo (o Google) para dejar de ser invitado anónimo.
class GuestEmailSheet extends StatefulWidget {
  const GuestEmailSheet({super.key, required this.hook});

  final String hook;

  @override
  State<GuestEmailSheet> createState() => _GuestEmailSheetState();
}

class _GuestEmailSheetState extends State<GuestEmailSheet> {
  final _email = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }

  void _close(GuestCaptureOutcome outcome) {
    Navigator.of(context).pop(outcome);
  }

  Future<void> _submitEmail() async {
    final state = context.read<AppState>();
    setState(() => _busy = true);
    final ok = await state.claimGuestEmail(_email.text);
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok) {
      _close(GuestCaptureOutcome.registered);
      return;
    }
    if (state.lastAuthNeedsLogin) {
      _close(GuestCaptureOutcome.needsLogin);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.lastError ?? 'No se pudo guardar el correo.'),
      ),
    );
  }

  Future<void> _submitGoogle() async {
    final state = context.read<AppState>();
    setState(() => _busy = true);
    final ok = await state.signInWithGoogle();
    if (!mounted) return;
    setState(() => _busy = false);
    if (ok && !state.isAnonymousUser) {
      _close(GuestCaptureOutcome.registered);
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(state.lastError ?? 'No se pudo entrar con Google.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 8, 22, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Guarda tu progreso', style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(widget.hook, style: theme.textTheme.bodyMedium),
            const SizedBox(height: 18),
            TextField(
              controller: _email,
              enabled: !_busy,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                if (!_busy) _submitEmail();
              },
              decoration: const InputDecoration(
                labelText: 'Correo electrónico',
                hintText: 'tucorreo@gmail.com',
              ),
            ),
            const SizedBox(height: 14),
            FilledButton(
              onPressed: _busy ? null : _submitEmail,
              child: Text(_busy ? 'Guardando…' : 'Guardar y continuar'),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: _busy ? null : _submitGoogle,
              icon: const Icon(Icons.g_mobiledata_rounded),
              label: const Text('Continuar con Google'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: _busy
                  ? null
                  : () => _close(GuestCaptureOutcome.goToLogin),
              child: const Text('Ya tengo cuenta'),
            ),
            TextButton(
              onPressed: _busy
                  ? null
                  : () => _close(GuestCaptureOutcome.dismissed),
              child: const Text('Ahora no'),
            ),
            const SizedBox(height: 4),
            Text(
              'Te enviamos un enlace para elegir tu contraseña. Así no pierdes el progreso.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
