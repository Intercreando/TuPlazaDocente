import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/auth_next.dart';
import '../utils/paid_traffic.dart';
import '../widgets/atmospheric_background.dart';
import '../widgets/brand_mark.dart';
import '../widgets/legal_footer_links.dart';

/// Acceso con Google, email o continuar como invitado.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _registerMode = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // Tráfico de anuncio: la landing promete simulación, no “iniciar sesión”.
    if (PaidTraffic.isPaid) {
      _registerMode = true;
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? get _nextPath => sanitizeNextPath(
        GoRouterState.of(context).uri.queryParameters['next'],
      );

  Future<void> _run(Future<bool> Function() action) async {
    final next = _nextPath;
    setState(() => _loading = true);
    final ok = await action();
    if (!mounted) return;
    setState(() => _loading = false);
    if (ok) {
      if (next != null) {
        if (next == '/premium' || next == '/app/premium') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Cuenta lista. Ya puedes adquirir Premium.'),
            ),
          );
        }
        context.go(next);
        return;
      }
      final onboarded = context.read<AppState>().profile.onboardingComplete;
      context.go(onboarded ? '/app' : '/onboarding');
    } else {
      final error = context.read<AppState>().lastError;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'No se pudo completar el acceso.')),
      );
    }
  }

  Future<void> _sendPasswordReset() async {
    final email = _emailController.text.trim();
    final messenger = ScaffoldMessenger.of(context);
    if (email.isEmpty || !email.contains('@')) {
      messenger.showSnackBar(
        const SnackBar(
          content: Text(
            'Escribe tu correo arriba y te enviamos el enlace para crear una nueva contraseña.',
          ),
        ),
      );
      return;
    }
    setState(() => _loading = true);
    final ok = await context.read<AppState>().sendPasswordReset(email);
    if (!mounted) return;
    setState(() => _loading = false);
    final error = context.read<AppState>().lastError;
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          ok
              ? 'Si hay una cuenta con ese correo, te enviamos un enlace. Revisa bandeja y spam. Si te registraste con Google, entra con Google.'
              : (error ?? 'No se pudo enviar el correo. Intenta de nuevo.'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final state = context.watch<AppState>();
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      body: AtmosphericBackground(
        dark: isDark,
        child: SafeArea(
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(22, 16, 22, 28),
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () {
                        if (context.canPop()) {
                          context.pop();
                        } else {
                          context.go('/');
                        }
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const BrandMark(compact: true),
                  const SizedBox(height: 22),
                  Text(
                    PaidTraffic.isPaid
                        ? 'Crea tu cuenta y entra al simulador'
                        : (_registerMode
                            ? 'Crea tu cuenta'
                            : 'Guarda tu progreso'),
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    PaidTraffic.isPaid
                        ? 'Con Google o correo, en segundos. Después eliges tu cargo y haces la primera simulación gratis.'
                        : 'Conecta tu cuenta para sincronizar racha, plan y Premium entre dispositivos.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  const LegalFooterLinks(compact: true),
                  const SizedBox(height: 18),
                  FilledButton.icon(
                    onPressed: _loading ? null : () => _run(state.signInWithGoogle),
                    icon: const Icon(Icons.g_mobiledata_rounded),
                    label: const Text('Continuar con Google'),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      const Expanded(child: Divider()),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text('o con correo', style: theme.textTheme.labelMedium),
                      ),
                      const Expanded(child: Divider()),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Correo',
                      hintText: 'tu@correo.com',
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Contraseña',
                      hintText: 'Mínimo 6 caracteres',
                    ),
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: _loading
                        ? null
                        : () {
                            final email = _emailController.text.trim();
                            final pass = _passwordController.text;
                            if (email.isEmpty || pass.length < 6) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Ingresa un correo válido y una contraseña de al menos 6 caracteres.',
                                  ),
                                ),
                              );
                              return;
                            }
                            _run(
                              () => _registerMode
                                  ? state.registerWithEmail(email, pass)
                                  : state.signInWithEmail(email, pass),
                            );
                          },
                    child: Text(_registerMode ? 'Crear cuenta' : 'Iniciar sesión'),
                  ),
                  if (!_registerMode)
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: _loading ? null : _sendPasswordReset,
                        child: const Text('¿Olvidaste tu contraseña?'),
                      ),
                    ),
                  TextButton(
                    onPressed: _loading
                        ? null
                        : () => setState(() => _registerMode = !_registerMode),
                    child: Text(
                      _registerMode
                          ? '¿Ya tienes cuenta? Inicia sesión'
                          : '¿Aún no tienes cuenta? Crear cuenta',
                    ),
                  ),
                  // Pauta o retorno a Premium: no ofrecer invitado (fuga de registro).
                  if (!state.isAnonymousUser ||
                      (!PaidTraffic.isPaid && _nextPath == null)) ...[
                    const SizedBox(height: 8),
                    OutlinedButton(
                      onPressed: _loading
                          ? null
                          : () {
                              final onboarded =
                                  state.profile.onboardingComplete;
                              context.go(onboarded ? '/app' : '/onboarding');
                            },
                      child: Text(
                        state.isAnonymousUser
                            ? 'Continuar como invitado'
                            : 'Volver a entrenar',
                      ),
                    ),
                  ],
                  if (!state.isAnonymousUser) ...[
                    const SizedBox(height: 8),
                    TextButton(
                      onPressed: _loading
                          ? null
                          : () async {
                              final messenger = ScaffoldMessenger.of(context);
                              final router = GoRouter.of(context);
                              setState(() => _loading = true);
                              final ok = await state.signOut();
                              if (!mounted) return;
                              setState(() => _loading = false);
                              messenger.showSnackBar(
                                SnackBar(
                                  content: Text(
                                    ok
                                        ? 'Sesión cerrada. Entraste como invitado sin el progreso de esa cuenta.'
                                        : state.lastError ??
                                            'No se pudo cerrar sesión.',
                                  ),
                                ),
                              );
                              if (ok) router.go('/');
                            },
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                  if (_loading) ...[
                    const SizedBox(height: 18),
                    const Center(
                      child: CircularProgressIndicator(color: AppColors.canopy),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
