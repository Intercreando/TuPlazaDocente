import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/admin_config.dart';
import '../services/promo_code_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/app_snackbars.dart';
import '../widgets/atmospheric_background.dart';

/// Panel admin: crear y gestionar códigos promocionales.
class AdminPromoScreen extends StatefulWidget {
  const AdminPromoScreen({super.key});

  @override
  State<AdminPromoScreen> createState() => _AdminPromoScreenState();
}

class _AdminPromoScreenState extends State<AdminPromoScreen> {
  final _service = PromoCodeService();
  final _codeCtrl = TextEditingController();
  final _noteCtrl = TextEditingController();
  final _maxCtrl = TextEditingController(text: '50');
  final _percentCtrl = TextEditingController(text: '30');

  String _type = 'grant';
  bool _loading = true;
  bool _saving = false;
  List<PromoCodeAdminItem> _items = const [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    final state = context.read<AppState>();
    if (!AdminConfig.isAdminEmail(state.authEmail)) {
      if (mounted) context.go('/app');
      return;
    }
    await _reload();
  }

  Future<void> _reload() async {
    setState(() => _loading = true);
    try {
      final items = await _service.adminList();
      if (!mounted) return;
      setState(() {
        _items = items;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _loading = false);
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _create() async {
    final code = _codeCtrl.text.trim().toUpperCase();
    if (code.length < 4) {
      AppSnackbars.show(context, message: 'El código debe tener al menos 4 caracteres.');
      return;
    }
    final max = int.tryParse(_maxCtrl.text.trim()) ?? 0;
    final percent = int.tryParse(_percentCtrl.text.trim()) ?? 0;
    setState(() => _saving = true);
    try {
      await _service.adminUpsert(
        code: code,
        type: _type,
        discountPercent: _type == 'discount' ? percent : 0,
        maxRedemptions: max,
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      );
      if (!mounted) return;
      _codeCtrl.clear();
      _noteCtrl.clear();
      AppSnackbars.show(context, message: 'Código $code guardado.');
      await _reload();
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _toggle(PromoCodeAdminItem item) async {
    try {
      await _service.adminSetActive(code: item.code, active: !item.active);
      await _reload();
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _copyCode(String code) async {
    try {
      await Clipboard.setData(ClipboardData(text: code));
      if (!mounted) return;
      AppSnackbars.show(context, message: 'Código $code copiado.');
    } catch (_) {
      if (!mounted) return;
      AppSnackbars.show(context, message: 'No se pudo copiar el código.');
    }
  }

  Future<void> _delete(PromoCodeAdminItem item) async {
    if (item.active) {
      AppSnackbars.show(
        context,
        message: 'Desactiva el código antes de borrarlo.',
      );
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          title: Text('¿Borrar ${item.code}?', style: theme.textTheme.titleLarge),
          content: Text(
            'Se eliminará de forma permanente. Esta acción no se puede deshacer.',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.of(ctx).pop(true),
              child: const Text('Borrar'),
            ),
          ],
        );
      },
    );
    if (confirmed != true || !mounted) return;
    try {
      await _service.adminDelete(code: item.code);
      if (!mounted) return;
      AppSnackbars.show(context, message: 'Código ${item.code} eliminado.');
      await _reload();
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  Future<void> _edit(PromoCodeAdminItem item) async {
    final result = await showDialog<_PromoEditResult>(
      context: context,
      builder: (ctx) => _PromoEditDialog(item: item),
    );
    if (result == null || !mounted) return;
    try {
      await _service.adminUpsert(
        code: item.code,
        type: result.type,
        discountPercent: result.type == 'discount' ? result.discountPercent : 0,
        maxRedemptions: result.maxRedemptions,
        note: result.note,
        active: item.active,
      );
      if (!mounted) return;
      AppSnackbars.show(context, message: 'Código ${item.code} actualizado.');
      await _reload();
    } catch (e) {
      if (!mounted) return;
      AppSnackbars.show(
        context,
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  @override
  void dispose() {
    _codeCtrl.dispose();
    _noteCtrl.dispose();
    _maxCtrl.dispose();
    _percentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final state = context.watch<AppState>();

    if (!AdminConfig.isAdminEmail(state.authEmail)) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Códigos promocionales'),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            onPressed: _loading ? null : _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: AtmosphericBackground(
        dark: isDark,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
              children: [
                Text(
                  'Crea códigos sin entrar a Firebase. Solo tu cuenta admin.',
                  style: theme.textTheme.bodyLarge,
                ),
                const SizedBox(height: 6),
                Text(
                  state.authEmail ?? '',
                  style: theme.textTheme.labelMedium,
                ),
                const SizedBox(height: 18),
                DecoratedBox(
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkSurface : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isDark ? AppColors.darkStroke : AppColors.stroke,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text('Nuevo código', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _codeCtrl,
                          textCapitalization: TextCapitalization.characters,
                          decoration: const InputDecoration(
                            labelText: 'Código',
                            hintText: 'PROMO-ABRIL',
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text('Tipo', style: theme.textTheme.titleSmall),
                        const SizedBox(height: 8),
                        SegmentedButton<String>(
                          segments: const [
                            ButtonSegment(
                              value: 'grant',
                              label: Text('Premium gratis'),
                              icon: Icon(Icons.card_giftcard_outlined),
                            ),
                            ButtonSegment(
                              value: 'discount',
                              label: Text('% descuento'),
                              icon: Icon(Icons.percent),
                            ),
                          ],
                          selected: {_type},
                          onSelectionChanged: (s) {
                            setState(() => _type = s.first);
                          },
                        ),
                        if (_type == 'discount') ...[
                          const SizedBox(height: 12),
                          TextField(
                            controller: _percentCtrl,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'Descuento (%)',
                              hintText: '30',
                              helperText: '1–99. El 100% se guarda como Premium gratis.',
                            ),
                          ),
                        ],
                        const SizedBox(height: 12),
                        TextField(
                          controller: _maxCtrl,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Usos máximos',
                            hintText: '50',
                            helperText: '0 = ilimitado',
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          controller: _noteCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Nota interna (opcional)',
                            hintText: 'Campaña abril',
                          ),
                        ),
                        const SizedBox(height: 16),
                        FilledButton.icon(
                          onPressed: _saving ? null : _create,
                          icon: const Icon(Icons.add),
                          label: Text(_saving ? 'Guardando…' : 'Crear / actualizar'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text('Códigos existentes', style: theme.textTheme.titleLarge),
                const SizedBox(height: 10),
                if (_loading)
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else if (_items.isEmpty)
                  Text(
                    'Aún no hay códigos.',
                    style: theme.textTheme.bodyMedium,
                  )
                else
                  for (final item in _items) ...[
                    _PromoAdminTile(
                      item: item,
                      onCopy: () => _copyCode(item.code),
                      onEdit: () => _edit(item),
                      onToggle: () => _toggle(item),
                      onDelete: item.active ? null : () => _delete(item),
                    ),
                    const SizedBox(height: 10),
                  ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PromoAdminTile extends StatelessWidget {
  const _PromoAdminTile({
    required this.item,
    required this.onCopy,
    required this.onEdit,
    required this.onToggle,
    required this.onDelete,
  });

  final PromoCodeAdminItem item;
  final VoidCallback onCopy;
  final VoidCallback onEdit;
  final VoidCallback onToggle;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final typeLabel = item.type == 'discount'
        ? '${item.discountPercent}% off'
        : 'Premium gratis';
    final uses = item.maxRedemptions <= 0
        ? '${item.redeemedCount} usos'
        : '${item.redeemedCount}/${item.maxRedemptions} usos';

    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.active
              ? (isDark ? AppColors.darkStroke : AppColors.stroke)
              : AppColors.coral.withValues(alpha: 0.45),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 8, 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: onCopy,
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(
                            child: Text(
                              item.code,
                              style: theme.textTheme.titleSmall,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.copy_rounded,
                            size: 18,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$typeLabel · $uses'
                    '${item.note == null || item.note!.isEmpty ? '' : ' · ${item.note}'}'
                    '${item.active ? '' : ' · OFF'}',
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: 'Copiar código',
              onPressed: onCopy,
              icon: const Icon(Icons.content_copy_outlined),
            ),
            IconButton(
              tooltip: 'Editar usos / descuento',
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
            ),
            TextButton(
              onPressed: onToggle,
              child: Text(item.active ? 'Desactivar' : 'Activar'),
            ),
            if (onDelete != null)
              IconButton(
                tooltip: 'Borrar código',
                onPressed: onDelete,
                icon: Icon(
                  Icons.delete_outline,
                  color: theme.colorScheme.error,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _PromoEditResult {
  const _PromoEditResult({
    required this.type,
    required this.discountPercent,
    required this.maxRedemptions,
    this.note,
  });

  final String type;
  final int discountPercent;
  final int maxRedemptions;
  final String? note;
}

class _PromoEditDialog extends StatefulWidget {
  const _PromoEditDialog({required this.item});

  final PromoCodeAdminItem item;

  @override
  State<_PromoEditDialog> createState() => _PromoEditDialogState();
}

class _PromoEditDialogState extends State<_PromoEditDialog> {
  late final TextEditingController _maxCtrl;
  late final TextEditingController _percentCtrl;
  late final TextEditingController _noteCtrl;
  late String _type;

  @override
  void initState() {
    super.initState();
    _type = widget.item.type == 'discount' ? 'discount' : 'grant';
    _maxCtrl = TextEditingController(text: '${widget.item.maxRedemptions}');
    _percentCtrl = TextEditingController(
      text: '${widget.item.discountPercent > 0 ? widget.item.discountPercent : 30}',
    );
    _noteCtrl = TextEditingController(text: widget.item.note ?? '');
  }

  @override
  void dispose() {
    _maxCtrl.dispose();
    _percentCtrl.dispose();
    _noteCtrl.dispose();
    super.dispose();
  }

  void _save() {
    final max = int.tryParse(_maxCtrl.text.trim()) ?? 0;
    final percent = int.tryParse(_percentCtrl.text.trim()) ?? 0;
    if (_type == 'discount' && (percent < 1 || percent > 99)) {
      AppSnackbars.show(
        context,
        message: 'El descuento debe estar entre 1 y 99.',
      );
      return;
    }
    Navigator.of(context).pop(
      _PromoEditResult(
        type: _type,
        discountPercent: percent,
        maxRedemptions: max < 0 ? 0 : max,
        note: _noteCtrl.text.trim().isEmpty ? null : _noteCtrl.text.trim(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
      title: Text('Editar ${widget.item.code}', style: theme.textTheme.titleLarge),
      content: SizedBox(
        width: 360,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Tipo', style: theme.textTheme.titleSmall),
              const SizedBox(height: 8),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(
                    value: 'grant',
                    label: Text('Gratis'),
                    icon: Icon(Icons.card_giftcard_outlined),
                  ),
                  ButtonSegment(
                    value: 'discount',
                    label: Text('% off'),
                    icon: Icon(Icons.percent),
                  ),
                ],
                selected: {_type},
                onSelectionChanged: (s) {
                  setState(() => _type = s.first);
                },
              ),
              if (_type == 'discount') ...[
                const SizedBox(height: 14),
                TextField(
                  controller: _percentCtrl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Descuento (%)',
                    helperText: '1–99',
                  ),
                ),
              ],
              const SizedBox(height: 14),
              TextField(
                controller: _maxCtrl,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Usos máximos',
                  helperText:
                      '0 = ilimitado · Ya usados: ${widget.item.redeemedCount}',
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: _noteCtrl,
                decoration: const InputDecoration(
                  labelText: 'Nota interna (opcional)',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _save,
          child: const Text('Guardar'),
        ),
      ],
    );
  }
}
