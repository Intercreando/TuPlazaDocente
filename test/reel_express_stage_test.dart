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
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> pumpStage(
    WidgetTester tester, {
    required ReelClip clip,
    required ReelBeat beat,
    int visibleOptionCount = 4,
  }) async {
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
          visibleOptionCount: visibleOptionCount,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 500));
  }

  test('el ciclo suma 15 s y las letras entran en el bloque del caso', () {
    expect(
      ReelExpressStage.hookMs +
          ReelExpressStage.questionMs +
          ReelExpressStage.countdownMs +
          ReelExpressStage.closeMs,
      ReelExpressStage.cycleMs,
    );
    expect(
      ReelExpressStage.optionCountAt(
        beat: ReelBeat.question,
        elapsedMs: ReelExpressStage.hookMs,
      ),
      0,
    );
    expect(
      ReelExpressStage.optionCountAt(
        beat: ReelBeat.question,
        elapsedMs: ReelExpressStage.hookMs +
            ReelExpressStage.optionDelayMs +
            ReelExpressStage.optionGapMs * 3,
      ),
      4,
    );
  });

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
        await pumpStage(tester, clip: clip, beat: beat);
        expect(
          tester.takeException(),
          isNull,
          reason: 'Desborde en ${clip.id} · $beat',
        );
      }
    }
  });

  testWidgets('el cierre pide comentar y no revela la correcta', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(tester, clip: clip, beat: ReelBeat.close);

    expect(find.text(ReelStudioPack.closeAsk), findsOneWidget);
    expect(find.text(ReelStudioPack.closePrompt), findsOneWidget);
    expect(find.text(clip.revealWhy), findsNothing);
    expect(find.text(ReelStudioPack.site), findsOneWidget);
    expect(find.text(ReelStudioPack.holdCue), findsNothing);
  });

  testWidgets('la portada usa el gancho del caso, no el genérico', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(tester, clip: clip, beat: ReelBeat.hook);

    expect(find.text(clip.hook), findsOneWidget);
    expect(find.text(ReelStudioPack.seriesKicker), findsOneWidget);
    expect(find.text(ReelClip.fallbackHook), findsNothing);
    expect(find.text(clip.stem), findsNothing);
  });

  testWidgets('el caso pide mantener presionado y no repite el gancho', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(tester, clip: clip, beat: ReelBeat.question);

    expect(find.text(clip.hook), findsNothing);
    expect(find.text(clip.stem), findsOneWidget);
    expect(find.text(ReelStudioPack.holdCue), findsOneWidget);
  });

  testWidgets('la cuenta atrás sale antes del cierre, con el reloj', (
    tester,
  ) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(tester, clip: clip, beat: ReelBeat.countdown);

    expect(find.text('3'), findsOneWidget);
    expect(find.text(ReelStudioPack.closeAsk), findsNothing);
    expect(find.text(clip.revealWhy), findsNothing);
  });

  testWidgets('las opciones aparecen de a una', (tester) async {
    final clip = ReelStudioPack.clips.first;
    await pumpStage(
      tester,
      clip: clip,
      beat: ReelBeat.question,
      visibleOptionCount: 2,
    );

    expect(find.text(clip.options[0]), findsOneWidget);
    expect(find.text(clip.options[1]), findsOneWidget);
    expect(find.text(clip.options[2]), findsNothing);
    expect(find.text(clip.options[3]), findsNothing);
  });
}
