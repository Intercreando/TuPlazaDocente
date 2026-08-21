import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tu_plaza_docente/data/reel_studio_pack.dart';
import 'package:tu_plaza_docente/theme/app_theme.dart';
import 'package:tu_plaza_docente/widgets/reel_express_stage.dart';

/// El lienzo de Reels usa tipografía grande para que el vídeo se lea en móvil.
/// Este test protege ese equilibrio: si un caso o un copy crece de más, el
/// layout debe seguir cabiendo en 1080×1920 sin desbordar.
void main() {
  setUpAll(() {
    // En pruebas no hay red: se usan las métricas de la fuente de respaldo.
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> pumpStage(
    WidgetTester tester, {
    required ReelClip clip,
    required ReelBeat beat,
    required bool revealMode,
  }) async {
    // El lienzo se diseña a 1080×1920: la superficie de prueba debe medir igual.
    await tester.binding.setSurfaceSize(ReelExpressStage.designSize);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: ReelExpressStage(
          clip: clip,
          beat: beat,
          countdownLeft: 3,
          countdownProgress: 0.5,
          revealMode: revealMode,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
  }

  testWidgets('ningún caso desborda el lienzo en ningún momento', (
    tester,
  ) async {
    const beats = [
      ReelBeat.hook,
      ReelBeat.question,
      ReelBeat.countdown,
      ReelBeat.close,
    ];

    for (final clip in ReelStudioPack.clips) {
      for (final beat in beats) {
        for (final revealMode in [false, true]) {
          await pumpStage(
            tester,
            clip: clip,
            beat: beat,
            revealMode: revealMode,
          );
          expect(
            tester.takeException(),
            isNull,
            reason: 'Desborde en ${clip.id} · $beat · revela=$revealMode',
          );
        }
      }
    }
  });

  testWidgets('el cierre sin revelar pide la letra y no repite las opciones', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(
      tester,
      clip: clip,
      beat: ReelBeat.close,
      revealMode: false,
    );

    expect(find.text(ReelStudioPack.closeAsk), findsOneWidget);
    expect(find.text(ReelStudioPack.closeComenta), findsOneWidget);
    for (final option in clip.options) {
      expect(find.text(option), findsNothing);
    }
  });

  testWidgets('la portada usa el gancho del caso, no el genérico', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(
      tester,
      clip: clip,
      beat: ReelBeat.hook,
      revealMode: false,
    );

    expect(find.text(clip.hook), findsOneWidget);
    expect(find.text(ReelStudioPack.closeAsk), findsOneWidget);
    expect(find.text(ReelStudioPack.seriesKicker), findsOneWidget);
    expect(find.text(ReelClip.fallbackHook), findsNothing);
  });

  testWidgets('la portada del capítulo 2 avisa que hoy se revela', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(
      tester,
      clip: clip,
      beat: ReelBeat.hook,
      revealMode: true,
    );

    expect(find.text(ReelStudioPack.revealKicker), findsOneWidget);
    expect(find.text(ReelStudioPack.revealPromise), findsOneWidget);
    expect(find.text(clip.hook), findsOneWidget);
    expect(find.text(clip.correctLetter), findsNothing);
    expect(find.text(ReelStudioPack.closeAsk), findsNothing);
    expect(find.text(ReelStudioPack.seriesKicker), findsNothing);
  });

  testWidgets('la pregunta no repite el gancho de la portada', (tester) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(
      tester,
      clip: clip,
      beat: ReelBeat.question,
      revealMode: false,
    );

    expect(find.text(clip.hook), findsNothing);
    expect(find.text(ReelClip.fallbackHook), findsNothing);
    expect(find.text(clip.stem), findsOneWidget);
  });
}
