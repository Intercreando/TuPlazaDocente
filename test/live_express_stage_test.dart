import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tu_plaza_docente/data/live_session.dart';
import 'package:tu_plaza_docente/data/live_studio_pack.dart';
import 'package:tu_plaza_docente/theme/app_theme.dart';
import 'package:tu_plaza_docente/widgets/live_express_stage.dart';

void main() {
  setUpAll(() {
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  Future<void> pumpStage(
    WidgetTester tester, {
    required ReelClip clip,
    required LiveBeat beat,
    int? highlightedIndex,
    String? nextLabel,
  }) async {
    await tester.binding.setSurfaceSize(LiveExpressStage.designSize);
    addTearDown(() => tester.binding.setSurfaceSize(null));

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light(),
        home: LiveExpressStage(
          clip: clip,
          beat: beat,
          countdownLeft: 12,
          countdownProgress: 0.6,
          highlightedIndex: highlightedIndex,
          nextLabel: nextLabel,
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 400));
  }

  testWidgets('ningún caso de directo desborda el lienzo 16:9', (tester) async {
    const beats = LiveBeat.values;
    final sample = [
      ...LiveStudioPack.enunciadoClips,
      if (LiveStudioPack.altaExigenciaClips().isNotEmpty)
        LiveStudioPack.altaExigenciaClips().first,
    ];
    for (final clip in sample) {
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

  testWidgets('la espera no adelanta el caso ni la respuesta', (tester) async {
    final clip = LiveStudioPack.enunciadoClips.first;
    await pumpStage(tester, clip: clip, beat: LiveBeat.standby);

    expect(find.text(LiveStudioPack.standbyTitle), findsOneWidget);
    expect(find.text(LiveStudioPack.soonBadge), findsWidgets);
    expect(find.text(clip.stem), findsNothing);
    expect(find.text(clip.revealWhy), findsNothing);
  });

  testWidgets('el gancho usa el hook del caso', (tester) async {
    final clip = LiveStudioPack.enunciadoClips.first;
    await pumpStage(tester, clip: clip, beat: LiveBeat.hook);

    expect(find.text(clip.hook), findsOneWidget);
    expect(find.text(LiveStudioPack.liveBadge), findsOneWidget);
    expect(find.text(clip.stem), findsNothing);
  });

  testWidgets('el caso pide voto en el chat y no revela', (tester) async {
    final clip = LiveStudioPack.enunciadoClips.first;
    await pumpStage(tester, clip: clip, beat: LiveBeat.question);

    expect(find.text(clip.stem), findsOneWidget);
    expect(find.text(clip.options.first), findsOneWidget);
    expect(find.text(LiveStudioPack.chatCue), findsWidgets);
    expect(find.text(clip.revealWhy), findsNothing);
  });

  testWidgets('la votación muestra el reloj y la consigna del chat', (
    tester,
  ) async {
    final clip = LiveStudioPack.enunciadoClips.first;
    await pumpStage(tester, clip: clip, beat: LiveBeat.vote);

    expect(find.text('12'), findsOneWidget);
    expect(find.text(LiveStudioPack.voteTitle), findsWidgets);
    expect(find.text(LiveStudioPack.chatCue), findsWidgets);
  });

  testWidgets('la revelación marca la correcta y deja la web a la vista', (
    tester,
  ) async {
    final clip = LiveStudioPack.enunciadoClips.first;
    await pumpStage(tester, clip: clip, beat: LiveBeat.reveal);

    expect(find.text(clip.revealWhy), findsOneWidget);
    expect(find.text(clip.options[clip.correctIndex]), findsOneWidget);
    expect(find.text(LiveStudioPack.site), findsWidgets);
  });

  testWidgets('el cierre empuja el registro', (tester) async {
    final clip = LiveStudioPack.enunciadoClips.first;
    await pumpStage(tester, clip: clip, beat: LiveBeat.cta);

    expect(find.text(LiveStudioPack.site), findsWidgets);
    expect(find.text(LiveStudioPack.closeAction), findsWidgets);
    expect(find.text(clip.stem), findsNothing);
  });
}
