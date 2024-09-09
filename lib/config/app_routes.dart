import 'package:ai_skill_assessment/modules/result/presentation/final_result_screen.dart';
import 'package:ai_skill_assessment/modules/question/presentation/question_screen.dart';
import 'package:ai_skill_assessment/modules/splash/presentation/splash_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  static const String splash = '/';
  static const String question = '/question';
  static const String result = '/result';

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
