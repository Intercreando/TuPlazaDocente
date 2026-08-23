import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'live_express_stage.dart';

/// Diagnóstico de nitidez para el directo 16:9.
///
/// YouTube pide 1920×1080. Si capturas la ventana de Chrome y el monitor es
/// más chico, OBS tiene que ampliar y el texto se ve suave.
class LiveCaptureNote extends StatelessWidget {
  const LiveCaptureNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final design = LiveExpressStage.designSize;
    final fit = math.min(
      media.size.width / design.width,
      media.size.height / design.height,
    );
    final scale = fit * media.devicePixelRatio;
    final capturedWidth = (design.width * scale).round();
    final capturedHeight = (design.height * scale).round();
    final native = capturedWidth >= design.width.round();

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(
          alpha: 0.35,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                native ? Icons.hd_rounded : Icons.blur_on_rounded,
                size: 18,
                color: native
                    ? theme.colorScheme.primary
                    : theme.colorScheme.error,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  native ? 'Captura nativa 1080p' : 'Captura por debajo de 1080p',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'No grabes el escritorio ni YouTube Studio. El lienzo ya está '
            'compuesto: casos, voto, revelación y hueco para tu cámara.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '1. En este panel avanzas el directo (espacio, V, N). '
            'Firestore actualiza el lienzo de OBS al instante.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '2. En OBS: Fuente → Navegador, 1920×1080, pega el enlace copiado. '
            'Luego Fuente → Captura de vídeo sobre el recuadro “Cámara”.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            'Esta ventana daría ≈ $capturedWidth×$capturedHeight px '
            '(${(scale * 100).round()}% del lienzo). '
            '${native ? 'Si capturas Chrome, la nitidez alcanza.' : 'Usa la fuente Navegador de OBS para 1920×1080 nativos.'} '
            'YouTube Studio queda en otra pantalla, solo para leer el chat.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
