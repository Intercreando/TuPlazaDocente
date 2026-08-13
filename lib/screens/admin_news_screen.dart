import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/admin_config.dart';
import '../models/news_item.dart';
import '../services/news_service.dart';
import '../state/app_state.dart';
import '../theme/app_colors.dart';
import '../utils/app_snackbars.dart';
import '../widgets/atmospheric_background.dart';
import 'admin_news_edit_dialog.dart';

/// Panel admin: crear, editar y borrar avisos de convocatoria.
class AdminNewsScreen extends StatefulWidget {
  const AdminNewsScreen({super.key});

  @override
  State<AdminNewsScreen> createState() => _AdminNewsScreenState();
}

class _AdminNewsScreenState extends State<AdminNewsScreen> {
  final _service = NewsService();
  bool _loading = true;
  List<NewsItem> _items = const [];

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

  Future<void> _edit([NewsItem? item]) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (ctx) => NewsEditDialog(item: item, service: _service),
    );
    if (saved == true && mounted) await _reload();
  }

  Future<void> _delete(NewsItem item) async {
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        final theme = Theme.of(ctx);
        return AlertDialog(
          title: Text('¿Borrar aviso?', style: theme.textTheme.titleLarge),
          content: Text(
            'Se eliminará “${item.title}”. No se puede deshacer.',
            style: theme.textTheme.bodyMedium,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Borrar'),
            ),
          ],
        );
      },
    );
    if (ok != true || !mounted) return;
    try {
      await _service.adminDelete(item.id);
      if (!mounted) return;
      AppSnackbars.show(context, message: 'Aviso eliminado.');
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
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final state = context.watch<AppState>();
    if (!AdminConfig.isAdminEmail(state.authEmail)) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Avisos y noticias'),
        actions: [
          IconButton(
            tooltip: 'Actualizar',
            onPressed: _loading ? null : _reload,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _edit(),
        icon: const Icon(Icons.add),
        label: const Text('Nuevo aviso'),
      ),
      body: AtmosphericBackground(
        dark: isDark,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 720),
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 96),
                    children: [
                      Text(
                        'Lo que publiques aquí sale en la landing y en Noticias.',
                        style: theme.textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 16),
                      if (_items.isEmpty)
                        Text(
                          'Aún no hay avisos.',
                          style: theme.textTheme.bodyMedium,
                        )
                      else
                        for (final item in _items) ...[
                          _AdminNewsTile(
                            item: item,
                            onEdit: () => _edit(item),
                            onDelete: () => _delete(item),
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

class _AdminNewsTile extends StatelessWidget {
  const _AdminNewsTile({
    required this.item,
    required this.onEdit,
    required this.onDelete,
  });

  final NewsItem item;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: item.published
              ? (isDark ? AppColors.darkStroke : AppColors.stroke)
              : AppColors.coral.withValues(alpha: 0.45),
        ),
      ),
      child: ListTile(
        title: Text(item.title, style: theme.textTheme.titleSmall),
        subtitle: Text(
          '${item.tagLabel}'
          '${item.pinned ? ' · Fijado' : ''}'
          '${item.published ? '' : ' · Oculto'}',
          style: theme.textTheme.bodySmall,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Editar',
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: 'Borrar',
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, color: theme.colorScheme.error),
            ),
          ],
        ),
      ),
    );
  }
}
