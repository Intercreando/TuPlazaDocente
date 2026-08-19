import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'reel_express_stage.dart';

/// Diagnóstico de nitidez para el estudio de grabación.
///
/// El lienzo se diseña a 1080×1920, pero al grabar la *pantalla* solo se
/// capturan los píxeles físicos que da el monitor. Si son menos de 1080 de
/// ancho, el editor tiene que ampliar el vídeo y el texto pierde nitidez.
/// Aquí se muestra el tamaño real y cómo obtener resolución nativa.
class ReelCaptureNote extends StatelessWidget {
  const ReelCaptureNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final design = ReelExpressStage.designSize;

    // En pantalla completa el lienzo se ajusta al lado más restrictivo.
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
                  native ? 'Captura nativa' : 'Captura por debajo de 1080',
                  style: theme.textTheme.titleSmall,
                ),
              ),
            ],
          ),
          Text(
            'Hay dos formas de grabar, y las dos empiezan aquí en Chrome:',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '1. Lo más simple: pulsa “Ver solo el lienzo en esta pestaña” '
            'y en OBS captura esa ventana de Chrome.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            '2. Lo más nítido: pulsa “Copiar enlace…” y, en OBS, crea '
            'Fuente → Navegador (no uses Chrome). Ancho 1080, alto 1920, '
            'y pega el enlace ahí. OBS trae su propio navegador interno: '
            'por eso el enlace no se pega en la barra de Chrome.',
            style: theme.textTheme.bodySmall,
          ),
          const SizedBox(height: 6),
          Text(
            'Esta ventana ahora mismo daría ≈ $capturedWidth×$capturedHeight px '
            '(${(scale * 100).round()}% del lienzo). '
            '${native ? 'Si capturas Chrome, la nitidez alcanza.' : 'Si capturas Chrome, el texto se verá un poco suave: usa la fuente Navegador de OBS para 1080×1920 nativos.'} '
            'Zoom de Chrome en 100%.',
            style: theme.textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
