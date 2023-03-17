import 'category_model.dart';
import 'question_model.dart';

class Quiz {
  final int id;
  final QuizCategory category;
  final String title;
  final Duration duration;
  final String imageURL;
  final List<QuizQuestion> questions;

  Quiz(
      {required this.duration,
      required this.id,
      required this.category,
      required this.title,
      required this.imageURL,
      required this.questions});
}
