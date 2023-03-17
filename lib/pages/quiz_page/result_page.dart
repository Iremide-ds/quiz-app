import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../util/general_constants.dart';
import '../quiz_page/provider/quiz_provider.dart';
import '../../widgets/rounded_container.dart';

class QuizResultPage extends StatefulWidget {
  static const String routeName = '/result';

  const QuizResultPage({Key? key}) : super(key: key);

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> with GeneralConstants {
  Widget _iconAndText(IconData icon, String text, String subtitle) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      subtitle: Text(
        subtitle,
        style: const TextStyle(color: Color(0xff999999)),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setContext = context;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(gradient: getGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: SizedBox(
            height: size.height,
            width: size.width,
            child: Consumer<QuizProvider>(
              builder: (ctx, provider, child) {
                final currentQuiz = provider.currentQuiz;

                return Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '${currentQuiz.title} quiz',
                      style: theme.primaryTextTheme.headlineLarge,
                    ),
                    SizedBox(height: size.height * 0.05),
                    RoundedBordersContainer(
                      height: size.height * 0.8,
                      width: size.width,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Your score:',
                            style:
                                theme.primaryTextTheme.headlineLarge!.copyWith(
                              color: theme.colorScheme.primary,
                            ),
                          ),
                          Text(
                            provider.totalScore.toString(),
                            style:
                                theme.primaryTextTheme.headlineLarge!.copyWith(
                              color: theme.colorScheme.secondary,
                              fontSize: 30,
                            ),
                          ),
                          _iconAndText(
                            (Platform.isIOS)
                                ? CupertinoIcons.list_bullet_below_rectangle
                                : Icons.receipt_outlined,
                            '${currentQuiz.questions.length.toString()} questions',
                            '1 point for each correct answer',
                          ),
                          _iconAndText(
                            (Platform.isIOS)
                                ? CupertinoIcons.time
                                : Icons.timer,
                            '${currentQuiz.duration.inHours.toString()} hours',
                            'Expected duration of the quiz',
                          ),
                          Expanded(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Thanks For taking this test. You can go back and check out other courses.',
                                    style: theme.primaryTextTheme.headlineLarge,
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
