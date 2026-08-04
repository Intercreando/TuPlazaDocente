import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../models/testimonial.dart';
import '../services/testimonial_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';

/// Bloque de opiniones (Landing / Home) con opción de contribuir.
class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({
    super.key,
    this.limit = 4,
    this.showCompose = true,
    this.compact = false,
    this.showSubtitle = true,
  });

  final int limit;
  final bool showCompose;
  final bool compact;
  final bool showSubtitle;

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final _service = TestimonialService();
  late Future<List<Testimonial>> _future;

  @override
  void initState() {
    super.initState();
    _future = _service.loadApproved(limit: widget.limit);
  }

  Future<void> _openCompose() async {
    final state = context.read<AppState>();
    if (state.isAnonymousUser) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Para comentar, guarda tu cuenta con Google o correo.',
          ),
          action: SnackBarAction(
            label: 'Cuenta',
            onPressed: () => context.push('/auth'),
          ),
        ),
      );
      return;
    }

    final ok = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (ctx) => _ComposeTestimonialSheet(
        initialName: state.profile.displayName.isNotEmpty
            ? state.profile.displayName
            : (state.authDisplayName ?? 'Aspirante'),
        roleLabel: state.profile.especialidad?.label ??
            state.profile.cargo?.label,
        onSubmit: (text, name, role) => _service.submit(
          text: text,
          displayName: name,
          roleLabel: role,
        ),
      ),
    );

    if (!mounted) return;
    if (ok == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Gracias. Revisaremos tu opinión antes de publicarla.',
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.compact ? 20 : 0),
      decoration: widget.compact
          ? BoxDecoration(
              color: isDark ? AppColors.darkSurface : AppColors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.colorScheme.outline),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Lo que cuentan otros aspirantes',
                  style: widget.compact
                      ? theme.textTheme.titleLarge
                      : theme.textTheme.headlineMedium,
                ),
              ),
              if (widget.showCompose)
                FilledButton.tonalIcon(
                  onPressed: _openCompose,
                  icon: const Icon(Icons.rate_review_outlined),
                  label: const Text('Cuéntanos lo tuyo'),
                ),
            ],
          ),
          if (widget.showSubtitle && !widget.compact) ...[
            const SizedBox(height: 8),
            Text(
              'Experiencias reales de quienes ya están preparándose aquí.',
              style: theme.textTheme.bodyMedium,
            ),
          ],
          const SizedBox(height: 18),
          FutureBuilder<List<Testimonial>>(
            future: _future,
            builder: (context, snap) {
              if (snap.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28),
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              final items = snap.data ?? const <Testimonial>[];
              if (items.isEmpty) {
                return Text(
                  'Aún no hay opiniones publicadas. Sé de las primeras en compartir.',
                  style: theme.textTheme.bodySmall,
                );
              }
              return LayoutBuilder(
                builder: (context, constraints) {
                  final w = constraints.maxWidth;
                  final columns = w >= 980
                      ? 3
                      : w >= 640
                          ? 2
                          : 1;
                  if (columns == 1) {
                    return Column(
                      children: [
                        for (final item in items) ...[
                          _TestimonialCard(item: item, elevated: widget.compact),
                          const SizedBox(height: 12),
                        ],
                      ],
                    );
                  }
                  final gap = 14.0;
                  final cardW = (w - gap * (columns - 1)) / columns;
                  return Wrap(
                    spacing: gap,
                    runSpacing: gap,
                    children: items
                        .map(
                          (item) => SizedBox(
                            width: cardW,
                            child: _TestimonialCard(
                              item: item,
                              elevated: widget.compact,
                              fillHeight: true,
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  const _TestimonialCard({
    required this.item,
    this.elevated = false,
    this.fillHeight = false,
  });

  final Testimonial item;
  final bool elevated;
  final bool fillHeight;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final card = Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: elevated
            ? (isDark
                ? AppColors.darkElevated
                : AppColors.mist.withValues(alpha: 0.65))
            : (isDark ? AppColors.darkSurface : AppColors.white),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: elevated
              ? AppColors.gold.withValues(alpha: 0.28)
              : theme.colorScheme.outline,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.format_quote_rounded,
            color: AppColors.goldDeep.withValues(alpha: 0.85),
          ),
          const SizedBox(height: 8),
          Text(
            item.text,
            style: theme.textTheme.bodyMedium,
          ),
          if (fillHeight) const Spacer(),
          const SizedBox(height: 14),
          Text(item.displayName, style: theme.textTheme.titleSmall),
          if (item.roleLabel != null && item.roleLabel!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Text(item.roleLabel!, style: theme.textTheme.labelMedium),
          ],
        ],
      ),
    );

    if (!fillHeight) return card;
    return SizedBox(height: 220, child: card);
  }
}

class _ComposeTestimonialSheet extends StatefulWidget {
  const _ComposeTestimonialSheet({
    required this.initialName,
    required this.onSubmit,
    this.roleLabel,
  });

  final String initialName;
  final String? roleLabel;
  final Future<void> Function(String text, String name, String? role) onSubmit;

  @override
  State<_ComposeTestimonialSheet> createState() =>
      _ComposeTestimonialSheetState();
}

class _ComposeTestimonialSheetState extends State<_ComposeTestimonialSheet> {
  late final TextEditingController _textController;
  late final TextEditingController _nameController;
  bool _busy = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
    _nameController = TextEditingController(text: widget.initialName);
  }

  @override
  void dispose() {
    _textController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final text = _textController.text.trim();
    final name = _nameController.text.trim();
    if (text.length < 20) {
      setState(() => _error = 'Escribe al menos 20 caracteres.');
      return;
    }
    if (name.length < 2) {
      setState(() => _error = 'Indica un nombre para mostrar.');
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await widget.onSubmit(text, name, widget.roleLabel);
      if (!mounted) return;
      Navigator.of(context).pop(true);
    } on FirebaseFunctionsException catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = e.message ?? 'No pudimos enviar tu opinión (${e.code}).';
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _busy = false;
        _error = e.toString().replaceFirst('Exception: ', '');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;

    return Padding(
      padding: EdgeInsets.fromLTRB(20, 8, 20, 20 + bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Tu opinión', style: theme.textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(
            'Se publicará solo después de revisión. Sé concreto y respetuoso.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 14),
          TextField(
            controller: _nameController,
            textCapitalization: TextCapitalization.words,
            decoration: const InputDecoration(
              labelText: 'Nombre a mostrar',
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: _textController,
            minLines: 4,
            maxLines: 6,
            maxLength: 400,
            textCapitalization: TextCapitalization.sentences,
            decoration: const InputDecoration(
              labelText: 'Tu comentario',
              alignLabelWithHint: true,
            ),
          ),
          if (_error != null) ...[
            Text(
              _error!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppColors.danger,
              ),
            ),
            const SizedBox(height: 8),
          ],
          FilledButton(
            onPressed: _busy ? null : _submit,
            child: Text(_busy ? 'Enviando…' : 'Enviar para revisión'),
          ),
        ],
      ),
    );
  }
}
