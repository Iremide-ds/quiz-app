import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../util/general_constants.dart';
import '../../widgets/rounded_container.dart';
import '../quiz_page/provider/quiz_provider.dart';
import '../quiz_page/provider/model/quiz_model.dart';
import '../quiz_page/quiz_page.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with GeneralConstants {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);
    final ThemeData theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(gradient: getGradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Hello there,',
                style: theme.primaryTextTheme.headlineSmall,
              ),
              Text(
                'Let us test your knowledge',
                style: theme.primaryTextTheme.headlineLarge,
              ),
              SizedBox(height: size.height * 0.05),
              Consumer<QuizProvider>(
                builder: (ctx1, provider, child) {
                  final quizzes = provider.quizzes;

                  if (quizzes.isEmpty) {
                    return child!;
                  }

                  return RoundedBordersContainer(
                    height: size.height * 0.8,
                    width: size.width,
                    child: ListView.builder(
                      itemCount: quizzes.length,
                      itemBuilder: (ctx, index) {
                        return QuizCard(quiz: quizzes[index]);
                      },
                    ),
                  );
                },
                child: const Text('Could not get quizzes!'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    setContext = context;
  }
}

class QuizCard extends StatelessWidget {
  final Quiz quiz;

  const QuizCard({Key? key, required this.quiz}) : super(key: key);

  Widget _iconAndText(IconData icon, String text, BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(icon, color: const Color(0xff999999), size: 13.0),
        SizedBox(width: MediaQuery.sizeOf(context).width * 0.001),
        Text(
          text,
          style: const TextStyle(
            color: Color(0xff999999),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.sizeOf(context);

    return GestureDetector(
      onTap: () {
        Provider.of<QuizProvider>(context, listen: false)
            .setCurrentQuiz(quiz.id);
        Navigator.of(context).pushNamed(QuizPage.routeName);
      },
      child: Card(
        margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
        surfaceTintColor: Colors.transparent,
        elevation: 10,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: size.height * 0.008),
          child: SizedBox(
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  quiz.imageURL,
                  height: size.height * 0.09,
                  width: size.width * 0.3,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(quiz.title),
                    _iconAndText(
                        (Platform.isIOS)
                            ? CupertinoIcons.list_bullet_below_rectangle
                            : Icons.receipt_outlined,
                        quiz.questions.length.toString(),
                        context),
                    _iconAndText(
                        (Platform.isIOS) ? CupertinoIcons.time : Icons.timer,
                        '${quiz.duration.inHours.toString()} hours',
                        context),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
