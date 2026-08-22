import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/data/reel_studio_pack.dart';

/// Reglas editoriales del catálogo de reels. Si un caso nuevo las rompe, el
/// video no cabe en el lienzo o la audiencia aprende a adivinar la letra.
void main() {
  final clips = ReelStudioPack.clips;

  test('los identificadores son únicos', () {
    final ids = clips.map((c) => c.id).toList();
    expect(ids.toSet().length, ids.length);
  });

  test('cada caso tiene cuatro opciones distintas y una correcta válida', () {
    for (final clip in clips) {
      expect(clip.options.length, 4, reason: clip.id);
      expect(
        clip.options.toSet().length,
        4,
        reason: 'opciones repetidas en ${clip.id}',
      );
      expect(clip.correctIndex, inInclusiveRange(0, 3), reason: clip.id);
    }
  });

  test('los textos caben en el lienzo con la tipografía grande', () {
    for (final clip in clips) {
      expect(clip.label.length, lessThanOrEqualTo(44), reason: clip.id);
      expect(clip.hook.length, lessThanOrEqualTo(56), reason: clip.id);
      expect(clip.hook, isNot(equals(ReelClip.fallbackHook)), reason: clip.id);
      expect(clip.situation.length, lessThanOrEqualTo(260), reason: clip.id);
      expect(clip.stem.length, lessThanOrEqualTo(90), reason: clip.id);
      expect(clip.revealWhy.length, lessThanOrEqualTo(150), reason: clip.id);
      for (final option in clip.options) {
        expect(
          option.length,
          lessThanOrEqualTo(95),
          reason: '${clip.id}: $option',
        );
      }
    }
  });

  test('las letras correctas están repartidas entre A, B, C y D', () {
    final counts = <int, int>{0: 0, 1: 0, 2: 0, 3: 0};
    for (final clip in clips) {
      counts[clip.correctIndex] = counts[clip.correctIndex]! + 1;
    }
    final minimo = clips.length ~/ 8; // al menos 12,5% por letra
    for (final entry in counts.entries) {
      expect(
        entry.value,
        greaterThanOrEqualTo(minimo),
        reason:
            'La letra ${'ABCD'[entry.key]} aparece muy poco: ${entry.value}',
      );
    }
  });

  test('hay volumen suficiente y todos los temas tienen casos', () {
    expect(clips.length, greaterThanOrEqualTo(20));
    for (final group in ReelStudioPack.groups) {
      expect(
        ReelStudioPack.byGroup(group).length,
        greaterThanOrEqualTo(3),
        reason: 'Pocos casos en ${group.label}',
      );
    }
  });

  test('la búsqueda encuentra por tema y por texto del caso', () {
    expect(ReelStudioPack.search('').length, clips.length);
    expect(ReelStudioPack.search('piar'), isNotEmpty);
    expect(ReelStudioPack.search('rector'), isNotEmpty);
    expect(ReelStudioPack.search('zzzznoexiste'), isEmpty);
  });

  test('byId recupera el caso y cae en el primero si no existe', () {
    expect(ReelStudioPack.byId('gratuidad').id, 'gratuidad');
    expect(ReelStudioPack.byId('inexistente').id, clips.first.id);
    expect(ReelStudioPack.byId(null).id, clips.first.id);
  });

  test('cada caso abre con un gancho distinto', () {
    final hooks = clips.map((c) => c.hook).toList();
    expect(hooks.toSet().length, hooks.length);
  });

  test('el caption pide comentario y no delata la respuesta', () {
    final clip = ReelStudioPack.byId('chat');
    final caption = ReelStudioPack.captionFor(clip);
    expect(caption, contains(clip.hook));
    expect(caption, contains(ReelStudioPack.commentNow));
    expect(caption, isNot(contains('Respuesta:')));
  });
}
