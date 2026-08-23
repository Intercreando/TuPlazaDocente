import 'package:flutter_test/flutter_test.dart';
import 'package:tu_plaza_docente/data/live_session.dart';
import 'package:tu_plaza_docente/data/live_studio_pack.dart';

void main() {
  test('los momentos avanzan y no se salen de la escaleta', () {
    expect(LiveBeat.standby.next, LiveBeat.hook);
    expect(LiveBeat.cta.next, LiveBeat.cta);
    expect(LiveBeat.hook.previous, LiveBeat.standby);
    expect(LiveBeat.standby.previous, LiveBeat.standby);
    expect(LiveBeat.parse('vote'), LiveBeat.vote);
    expect(LiveBeat.parse('no-existe'), LiveBeat.standby);
  });

  test('fromMap tolera documentos incompletos', () {
    final session = LiveSession.fromMap(const {}, fallbackId: 'chat');
    expect(session.clipId, 'chat');
    expect(session.beat, LiveBeat.standby);
    expect(session.voteEndsAtMs, isNull);
    expect(session.highlightedIndex, isNull);
  });

  test('el reloj de voto solo corre en ese momento', () {
    final now = DateTime.fromMillisecondsSinceEpoch(10 * 1000);
    final voting = LiveSession(
      clipId: 'chat',
      beat: LiveBeat.vote,
      voteEndsAtMs: 25 * 1000,
    );
    expect(voting.countdownLeftAt(now), 15);
    expect(
      voting.countdownProgressAt(now, voteMs: LiveStudioPack.voteMs),
      15 * 1000 / LiveStudioPack.voteMs,
    );

    final idle = voting.copyWith(beat: LiveBeat.question, clearVote: true);
    expect(idle.countdownLeftAt(now), isNull);
    expect(idle.voteEndsAtMs, isNull);
  });

  test('copyWith puede borrar el siguiente caso de la escaleta', () {
    const session = LiveSession(
      clipId: 'chat',
      beat: LiveBeat.hook,
      nextClipId: 'piar',
    );
    expect(session.copyWith(clearNext: true).nextClipId, isNull);
  });

  test('la votación del directo dura más que un reel', () {
    expect(LiveStudioPack.voteMs, greaterThanOrEqualTo(15000));
    expect(LiveStudioPack.site, 'tuplazadocente.com');
    expect(LiveStudioPack.chatCue, contains('chat'));
  });
}
