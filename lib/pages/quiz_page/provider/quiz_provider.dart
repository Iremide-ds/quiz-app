import 'package:flutter/material.dart';

import 'model/answer_model.dart';
import 'model/question_model.dart';
import 'model/quiz_model.dart';
import 'model/category_model.dart';

/// Provider for all quiz related logic
class QuizProvider with ChangeNotifier {
  /// all available quizzes
  final List<Quiz> _quizzes = [
    Quiz(
      imageURL: 'assets/quiz/flutter.jpg',
      duration: const Duration(minutes: 1),
      id: 1,
      category: QuizCategory(id: 1, title: 'Coding'),
      title: 'Flutter',
      questions: [
        QuizQuestion(
          options: [
            QuizAnswer('A Game', 1),
            QuizAnswer('A Framework', 2),
            QuizAnswer('A sport', 3),
            QuizAnswer('A song', 4),
          ],
          id: 1,
          question: 'What is Flutter?',
          answerID: 2,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Java', 1),
            QuizAnswer('Kotlin', 2),
            QuizAnswer('Python', 3),
            QuizAnswer('Dart', 4),
          ],
          id: 2,
          question: 'Which language does Flutter use?',
          answerID: 4,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Singing', 1),
            QuizAnswer('Washing', 2),
            QuizAnswer('Building software', 3),
            QuizAnswer('None of the above', 4),
          ],
          id: 3,
          question: 'What is Flutter used for?',
          answerID: 3,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Maybe', 1),
            QuizAnswer('Yes', 2),
            QuizAnswer('No', 3),
            QuizAnswer('All of the above', 4),
          ],
          id: 4,
          question: 'Can flutter build websites?',
          answerID: 2,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Container', 1),
            QuizAnswer('Cuntainer', 2),
            QuizAnswer('container', 3),
            QuizAnswer('All of the above', 4),
          ],
          id: 5,
          question:
              'Which of the following is a correct widget provided by material.dart?',
          answerID: 1,
        ),
      ],
    ),
    Quiz(
      imageURL: 'assets/quiz/html.png',
      duration: const Duration(hours: 2),
      id: 2,
      category: QuizCategory(id: 1, title: 'Coding'),
      title: 'HTML',
      questions: [
        QuizQuestion(
          options: [
            QuizAnswer('An Animal', 1),
            QuizAnswer('A mark up language', 2),
            QuizAnswer('A style', 3),
            QuizAnswer('A brand', 4),
          ],
          id: 1,
          question: 'WHat is HTML',
          answerID: 2,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Building websites', 1),
            QuizAnswer('Building houses', 2),
            QuizAnswer('Building roads', 3),
            QuizAnswer('None of the above', 4),
          ],
          id: 2,
          question: 'What is Html used for?',
          answerID: 1,
        ),
        QuizQuestion(
          options: [
            QuizAnswer("'<p>Hello world<</p>'", 1),
            QuizAnswer("'<p>Hello world;</p>'", 2),
            QuizAnswer("'<p>>Hello world</p>'", 3),
            QuizAnswer("'<p>Hello world</h1>'", 4),
          ],
          id: 3,
          question: 'Which of the following is correct?',
          answerID: 2,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Hyper Text MarkUp Language', 1),
            QuizAnswer('Hyper Text MarkUp Languages', 2),
            QuizAnswer('All of the Above', 3),
            QuizAnswer('None of the above', 4),
          ],
          id: 4,
          question: 'What is the full meaning of HTML?',
          answerID: 1,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('Maybe', 1),
            QuizAnswer('Yes', 2),
            QuizAnswer('No', 3),
            QuizAnswer('All of the above', 4),
          ],
          id: 5,
          question: 'Can Html build a website?',
          answerID: 2,
        ),
        QuizQuestion(
          options: [
            QuizAnswer('CSS', 1),
            QuizAnswer('CSSS', 2),
            QuizAnswer('Flutter', 3),
            QuizAnswer('All of the above', 4),
          ],
          id: 6,
          question: 'Which of the following is used for styling HTML?',
          answerID: 1,
        ),
      ],
    ),
  ];

  List<Quiz> get quizzes {
    debugPrint('Fetching Quizzes');
    return List.from(_quizzes);
  }

  Quiz? _currentQuiz;

  Quiz get currentQuiz {
    return _currentQuiz!;
  }

  void setCurrentQuiz(int quizID) {
    _currentQuiz = _quizzes.firstWhere((element) => element.id == quizID);
    notifyListeners();
  }

  /// get a specific quiz
  Quiz getQuiz(int index) {
    if (index >= _quizzes.length) {
      debugPrint('index out of bounds!');
      return _quizzes.last;
    } else {
      return _quizzes[index];
    }
  }

  /// storage for answers
  final List<Map<String, int>> _answers = [];

  /// the total score variable
  int _totalScore = 0;

  int get totalScore => int.parse(_totalScore.toString());

  set totalScore(int value) {
    _totalScore = value;
  }

  /// Store answer for a question
  void answerQuestion(int quizID, int questionIndex, int chosenAnswer) {
    Map<String, int> alreadyAnswered = {};
    for (Map<String, int> i in _answers) {
      if (i['quiz'] == quizID &&
          i['question'] ==
              _quizzes
                  .firstWhere((element) => element.id == quizID)
                  .questions[questionIndex]
                  .id) {
        alreadyAnswered = i;
        break;
      }
    }

    if (alreadyAnswered.isNotEmpty) {
      _answers.remove(alreadyAnswered);
    }

    _answers.add({
      'question': _quizzes
          .firstWhere((element) => element.id == quizID)
          .questions[questionIndex]
          .id,
      'answer': chosenAnswer,
      'quiz': _quizzes.firstWhere((element) => element.id == quizID).id,
    });
  }

  /// Calculate result for [currentQuiz]
  void compileResult() {
    if (_answers.isEmpty) return;

    totalScore = 0;

    for (Map<String, int> i in _answers) {
      int answerID = i['answer']!;
      int questionID = i['question']!;
      int quizID = i['quiz']!;

      final quiz = _quizzes.firstWhere((element) => element.id == quizID);
      final quizQuestion =
          quiz.questions.firstWhere((element) => element.id == questionID);

      if (quizQuestion.answerID == answerID) {
        totalScore = totalScore + 1;
      }
    }
    _answers.clear();
  }
}
