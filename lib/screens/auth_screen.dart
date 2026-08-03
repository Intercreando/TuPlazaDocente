import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../state/app_state.dart';
import '../theme/app_colors.dart';
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
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _run(Future<bool> Function() action) async {
    setState(() => _loading = true);
    final ok = await action();
    if (!mounted) return;
    setState(() => _loading = false);
    if (ok) {
      final onboarded = context.read<AppState>().profile.onboardingComplete;
      context.go(onboarded ? '/app' : '/onboarding');
    } else {
      final error = context.read<AppState>().lastError;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error ?? 'No se pudo completar el acceso.')),
      );
    }
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
                      onPressed: () => context.go('/'),
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  const BrandMark(compact: true),
                  const SizedBox(height: 22),
                  Text(
                    _registerMode ? 'Crea tu cuenta' : 'Guarda tu progreso',
                    style: theme.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Conecta tu cuenta para sincronizar racha, plan y Premium entre dispositivos.',
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
                  const SizedBox(height: 8),
                  OutlinedButton(
                    onPressed: _loading
                        ? null
                        : () {
                            final onboarded = state.profile.onboardingComplete;
                            context.go(onboarded ? '/app' : '/onboarding');
                          },
                    child: Text(
                      state.isAnonymousUser
                          ? 'Continuar como invitado'
                          : 'Volver a entrenar',
                    ),
                  ),
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
