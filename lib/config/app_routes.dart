import 'package:ai_skill_assessment/modules/final_result/presentation/final_result_screen.dart';
import 'package:ai_skill_assessment/modules/question/presentation/question_screen.dart';
import 'package:ai_skill_assessment/modules/result/presentation/result_screen.dart';
import 'package:ai_skill_assessment/modules/splash/presentation/splash_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String question = '/question';
  static const String result = '/result';
  static const String finalResult = '/finalResult';

  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case question:
        return MaterialPageRoute(
          builder: (context) => const QuestionScreen(),
        );
      case result:
        ResultScreenArguments args =
            settings.arguments as ResultScreenArguments;
        return MaterialPageRoute(
          builder: (context) => ResultScreen(args: args),
        );
      case finalResult:
        return MaterialPageRoute(
          builder: (context) => const FinalResultScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Error'),
          ),
          body: const Center(
            child: Text('Page Not Found'),
          ),
        );
      },
    );
  }
}

class ResultScreenArguments extends Equatable {
  final double percentage;
  final int correctAnswerCount;
  final int totalQuestionsCount;
  final int level;

  const ResultScreenArguments({
    required this.percentage,
    required this.correctAnswerCount,
    required this.totalQuestionsCount,
    required this.level,
  });
  @override
  List<Object> get props => [
        percentage,
        correctAnswerCount,
        totalQuestionsCount,
        level,
      ];
}
