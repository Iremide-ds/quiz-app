import 'answer_model.dart';

class QuizQuestion {
  final int id;
  final String question;
  final int answerID;
  final List<QuizAnswer> options;

  QuizQuestion({required this.options,
      required this.id, required this.question, required this.answerID});
}
