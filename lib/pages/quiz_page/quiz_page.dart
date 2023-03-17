import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../util/general_constants.dart';
import 'provider/quiz_provider.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  static const String routeName = '/quiz';

  const QuizPage({Key? key}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with GeneralConstants {
  List<int?> _radioValue = [];

  List<int?> get _value {
    return List.generate(
        Provider.of<QuizProvider>(context, listen: false)
            .currentQuiz
            .questions
            .length,
        (index) => null);
  }

  @override
  void initState() {
    super.initState();
    setContext = context;
    _radioValue = _value;
    debugPrint(_radioValue.length.toString());
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return Container(
      decoration: BoxDecoration(gradient: getGradient),
      child: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          title: Text(
              '${Provider.of<QuizProvider>(context, listen: false).currentQuiz.title} Quiz'),
          centerTitle: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0.0,
        ),
        body: SafeArea(
          child: Container(
            height: size.height,
            width: size.width,
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
            child: Consumer<QuizProvider>(
              builder: (ctx1, provider, child) {
                final currentQuiz = provider.currentQuiz;

                return ListView.builder(
                  itemCount: currentQuiz.questions.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (ctx, index) {
                    if (index >= currentQuiz.questions.length) {
                      return ElevatedButton(
                        onPressed: () {
                          provider.compileResult();
                          Navigator.of(context)
                              .pushReplacementNamed(QuizResultPage.routeName);
                        },
                        child: const Text('Submit'),
                      );
                    }

                    final currentQuestion = currentQuiz.questions[index];

                    return Card(
                      surfaceTintColor: Colors.transparent,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.01,
                          horizontal: size.width * 0.01,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              currentQuestion.question,
                              style: Theme.of(context)
                                  .primaryTextTheme
                                  .headlineMedium,
                              textAlign: TextAlign.center,
                            ),
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: currentQuestion.options.length,
                              itemBuilder: (ctx2, index2) {
                                final currentOption =
                                    currentQuestion.options[index2];

                                return RadioListTile(
                                  value: currentOption.id,
                                  groupValue: _radioValue[index],
                                  title: Text(currentOption.answer),
                                  onChanged: (val) {
                                    setState(() {
                                      _radioValue[index] = val;
                                    });
                                    provider.answerQuestion(currentQuiz.id,
                                        index, _radioValue[index]!);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
