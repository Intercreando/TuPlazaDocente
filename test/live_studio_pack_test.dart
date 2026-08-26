import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/data/live_clip_mapper.dart';
import 'package:tu_plaza_docente/data/live_gem_prompt.dart';
import 'package:tu_plaza_docente/data/live_studio_pack.dart';
import 'package:tu_plaza_docente/data/reel_clip_text_parser.dart';
import 'package:tu_plaza_docente/data/reel_studio_pack.dart';

void main() {
  test('el directo no reutiliza los ids del pack de Reels', () {
    final liveIds = LiveStudioPack.catalog().map((c) => c.id).toSet();
    final reelIds = ReelStudioPack.clips.map((c) => c.id).toSet();
    expect(liveIds.intersection(reelIds), isEmpty);
  });

  test('los enunciados de directo son más largos que un recorte de Reel', () {
    for (final clip in LiveStudioPack.enunciadoClips) {
      expect(
        clip.situation.length,
        greaterThan(120),
        reason: clip.id,
      );
      expect(clip.options.length, 4);
    }
  });

  test('incluye casos de alta exigencia del banco', () {
    final alta = LiveStudioPack.altaExigenciaClips();
    expect(alta, isNotEmpty);
    expect(alta.length, lessThanOrEqualTo(LiveStudioPack.maxAltaClips));
    for (final clip in alta) {
      expect(clip.id, startsWith(liveAltaIdPrefix));
      expect(clip.label.toLowerCase(), contains('alta'));
    }
  });

  test('el ejemplo del Gem de directo se pega completo', () {
    final draft = ReelClipTextParser.parse(
      LiveGemPrompt.ejemplo,
      limits: ClipParseLimits.live,
    );
    expect(draft.errors, isEmpty);
    expect(draft.isValid, isTrue);
    expect(draft.clip!.group, ReelGroup.inclusion);
    expect(draft.clip!.correctIndex, 2);
    expect(draft.clip!.situation, contains('Decreto 1421'));
    expect(draft.warnings, isEmpty);
  });
}
