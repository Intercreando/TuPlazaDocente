import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../data/reel_studio_pack.dart';
import '../utils/app_snackbars.dart';

/// Kit de publicación: caption, hashtags y comentario fijado del clip.
class ReelPublishKit extends StatelessWidget {
  const ReelPublishKit({super.key, required this.clip});

  final ReelClip clip;

  Future<void> _copy(BuildContext context, String text, String ok) async {
    try {
      await Clipboard.setData(ClipboardData(text: text));
      if (!context.mounted) return;
      AppSnackbars.show(context, message: ok);
    } catch (_) {
      if (!context.mounted) return;
      AppSnackbars.show(
        context,
        message: 'No se pudo copiar. Inténtalo de nuevo.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Copiar para publicar', style: theme.textTheme.titleSmall),
        const SizedBox(height: 4),
        Text(
          'Pega el caption en TikTok. Trae palabra clave del tema y hashtags '
          'de búsqueda. La letra no va en el pie: el vídeo la revela al cierre.',
          style: theme.textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () => _copy(
            context,
            ReelStudioPack.captionFor(clip),
            'Caption copiado.',
          ),
          child: const Text('Copiar caption'),
        ),
        const SizedBox(height: 6),
        OutlinedButton(
          onPressed: () => _copy(
            context,
            ReelStudioPack.hashtagsFor(clip),
            'Hashtags copiados.',
          ),
          child: const Text('Copiar hashtags'),
        ),
        const SizedBox(height: 6),
        OutlinedButton(
          onPressed: () => _copy(
            context,
            ReelStudioPack.pinnedComment,
            'Comentario fijado copiado.',
          ),
          child: const Text('Copiar comentario fijado'),
        ),
      ],
    );
  }
}
