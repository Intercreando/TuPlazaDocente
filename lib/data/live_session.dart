/// Momentos que el anfitrión avanza a mano. Un directo no es un reel de 15 s:
/// el chat necesita tiempo para votar y para discutir la trampa.
enum LiveBeat {
  standby,
  hook,
  question,
  vote,
  reveal,
  cta;

  LiveBeat get next {
    final nextIndex = (index + 1).clamp(0, values.length - 1);
    return values[nextIndex];
  }

  LiveBeat get previous {
    final prevIndex = (index - 1).clamp(0, values.length - 1);
    return values[prevIndex];
  }

  String get label {
    switch (this) {
      case LiveBeat.standby:
        return 'Espera';
      case LiveBeat.hook:
        return 'Gancho';
      case LiveBeat.question:
        return 'Caso';
      case LiveBeat.vote:
        return 'Voto';
      case LiveBeat.reveal:
        return 'Revelar';
      case LiveBeat.cta:
        return 'Cierre';
    }
  }

  static LiveBeat parse(String? raw) {
    for (final beat in values) {
      if (beat.name == raw) return beat;
    }
    return LiveBeat.standby;
  }
}

/// Estado que el panel admin publica y que el lienzo de OBS escucha.
class LiveSession {
  const LiveSession({
    required this.clipId,
    required this.beat,
    this.voteEndsAtMs,
    this.highlightedIndex,
    this.nextClipId,
  });

  final String clipId;
  final LiveBeat beat;
  final int? voteEndsAtMs;
  final int? highlightedIndex;
  final String? nextClipId;

  LiveSession copyWith({
    String? clipId,
    LiveBeat? beat,
    int? voteEndsAtMs,
    int? highlightedIndex,
    String? nextClipId,
    bool clearVote = false,
    bool clearHighlight = false,
    bool clearNext = false,
  }) {
    return LiveSession(
      clipId: clipId ?? this.clipId,
      beat: beat ?? this.beat,
      voteEndsAtMs: clearVote ? null : (voteEndsAtMs ?? this.voteEndsAtMs),
      highlightedIndex:
          clearHighlight ? null : (highlightedIndex ?? this.highlightedIndex),
      nextClipId: clearNext ? null : (nextClipId ?? this.nextClipId),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clipId': clipId,
      'beat': beat.name,
      'voteEndsAtMs': voteEndsAtMs,
      'highlightedIndex': highlightedIndex,
      'nextClipId': nextClipId,
    };
  }

  static LiveSession fromMap(Map<String, dynamic> data, {String? fallbackId}) {
    final highlight = data['highlightedIndex'];
    final voteEnds = data['voteEndsAtMs'];
    final nextId = '${data['nextClipId'] ?? ''}'.trim();
    return LiveSession(
      clipId: '${data['clipId'] ?? fallbackId ?? ''}',
      beat: LiveBeat.parse(data['beat'] as String?),
      voteEndsAtMs: voteEnds is int ? voteEnds : null,
      highlightedIndex: highlight is int ? highlight : null,
      nextClipId: nextId.isEmpty ? null : nextId,
    );
  }

  /// Segundos que faltan para cerrar la votación. `null` si no hay reloj.
  int? countdownLeftAt(DateTime now) {
    final ends = voteEndsAtMs;
    if (ends == null || beat != LiveBeat.vote) return null;
    final left = ((ends - now.millisecondsSinceEpoch) / 1000).ceil();
    return left < 0 ? 0 : left;
  }

  double countdownProgressAt(DateTime now, {required int voteMs}) {
    final ends = voteEndsAtMs;
    if (ends == null || beat != LiveBeat.vote || voteMs <= 0) return 0;
    final left = ends - now.millisecondsSinceEpoch;
    return (left / voteMs).clamp(0.0, 1.0);
  }
}
