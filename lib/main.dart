import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'app_theme/app_theme.dart';
import 'pages/quiz_page/provider/quiz_provider.dart';
import 'pages/landing_page/landing_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/quiz_page/quiz_page.dart';
import 'pages/quiz_page/result_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (_) => QuizProvider())],
    child: const MyApp(),
  ));
}

/// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme = AppTheme();

    return MaterialApp(
      title: 'Quizz',
      theme: appTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      routes: {
        '/':(_) => const LandingPage(),
            HomePage.routeName: (_) => const HomePage(),
        QuizPage.routeName: (_) => const QuizPage(),
        QuizResultPage.routeName: (_) => const QuizResultPage(),
      },
    );
  }
}
