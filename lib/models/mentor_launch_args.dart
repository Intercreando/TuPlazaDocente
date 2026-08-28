import 'question.dart';

/// Caso y postura con los que abre el Mentor IA.
class MentorLaunchArgs {
  const MentorLaunchArgs({required this.question, required this.chosenIndex});

  final Question question;
  final int chosenIndex;
}
