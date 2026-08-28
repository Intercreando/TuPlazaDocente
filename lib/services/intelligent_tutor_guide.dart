import '../models/question.dart';
import 'tutor_scaffold_copy.dart';

/// Qué debe mostrar la UI después de una postura.
enum TutorChoiceOutcome {
  ignored,
  hint,
  primaryFirstTry,
  primaryRecovered,
  primaryRevealed,
  followUpRevealed,
}

/// Andamiaje de un caso: 1 reintento con pista, luego se revela.
/// El segundo ítem (si hay) es una sola postura, para comprobar la clave.
class IntelligentTutorGuide {
  IntelligentTutorGuide({required this.primary, this.followUp});

  static const maxPrimaryAttempts = 2;

  final Question primary;
  Question? followUp;

  final eliminated = <int>{};
  int primaryAttempts = 0;
  int? primaryChoice;
  var primaryClosed = false;
  var firstTryCorrect = false;
  String hint = '';

  var showingFollowUp = false;
  int? followUpChoice;
  var followUpClosed = false;

  Question get current =>
      showingFollowUp && followUp != null ? followUp! : primary;

  bool get awaitingRetry =>
      !primaryClosed && !showingFollowUp && primaryAttempts == 1;

  bool get canOfferFollowUp =>
      primaryClosed && !showingFollowUp && followUp != null;

  void attachFollowUp(Question? next) {
    if (primaryClosed && !showingFollowUp) {
      followUp = next;
    }
  }

  /// Aplica una opción del ítem actual. Las ya tachadas no cuentan.
  TutorChoiceOutcome choose(int index) {
    if (showingFollowUp) {
      return _chooseFollowUp(index);
    }
    return _choosePrimary(index);
  }

  void startFollowUp() {
    if (!canOfferFollowUp) return;
    showingFollowUp = true;
  }

  TutorChoiceOutcome _choosePrimary(int index) {
    if (primaryClosed) return TutorChoiceOutcome.ignored;
    if (eliminated.contains(index)) return TutorChoiceOutcome.ignored;
    if (index < 0 || index >= primary.options.length) {
      return TutorChoiceOutcome.ignored;
    }

    primaryChoice = index;
    primaryAttempts += 1;
    final correct = primary.isCorrect(index);

    if (correct) {
      primaryClosed = true;
      firstTryCorrect = primaryAttempts == 1;
      hint = '';
      return firstTryCorrect
          ? TutorChoiceOutcome.primaryFirstTry
          : TutorChoiceOutcome.primaryRecovered;
    }

    eliminated.add(index);
    if (primaryAttempts < maxPrimaryAttempts) {
      hint = TutorScaffoldCopy.hintFor(primary, index);
      return TutorChoiceOutcome.hint;
    }
    primaryClosed = true;
    firstTryCorrect = false;
    return TutorChoiceOutcome.primaryRevealed;
  }

  TutorChoiceOutcome _chooseFollowUp(int index) {
    final item = followUp;
    if (item == null || followUpClosed) return TutorChoiceOutcome.ignored;
    if (index < 0 || index >= item.options.length) {
      return TutorChoiceOutcome.ignored;
    }
    followUpChoice = index;
    followUpClosed = true;
    return TutorChoiceOutcome.followUpRevealed;
  }
}
