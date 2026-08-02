import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tts_service.dart';
import '../theme/app_colors.dart';

/// Botón compacto para escuchar / detener un bloque de texto.
class ListenButton extends StatelessWidget {
  const ListenButton({
    super.key,
    required this.text,
    required this.speakKey,
    this.label = 'Escuchar',
    this.stopLabel = 'Detener',
  });

  final String text;
  final String speakKey;
  final String label;
  final String stopLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tts = context.watch<TtsService>();
    final playing = tts.isPlaying(speakKey);
    final isDark = theme.brightness == Brightness.dark;

    return OutlinedButton.icon(
      onPressed: text.trim().isEmpty
          ? null
          : () {
              // Síncrono: el navegador móvil exige el speak en el mismo toque.
              tts.toggle(text, key: speakKey);
              // El error puede llegar un instante después (onerror).
              Future<void>.delayed(const Duration(milliseconds: 400), () {
                if (!context.mounted) return;
                final error = tts.lastError;
                if (error != null && !tts.isSpeaking) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                }
              });
            },
      icon: Icon(
        playing ? Icons.stop_circle_outlined : Icons.volume_up_rounded,
        color: playing
            ? AppColors.coral
            : (isDark ? AppColors.seafoam : AppColors.canopy),
      ),
      label: Text(
        tts.isLoading && tts.activeKey == speakKey
            ? 'Preparando voz…'
            : (playing ? stopLabel : label),
      ),
    );
  }
}
