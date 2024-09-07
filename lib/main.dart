import 'package:flutter/material.dart';
import 'package:ai_skill_assessment/question/presentation/question_screen.dart';
import 'package:ai_skill_assessment/service_locator.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:toastification/toastification.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator().then(
    (_) => runApp(
      const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: appWhite,
          useMaterial3: true,
        ),
        home: const QuestionScreen(),
      ),
    );
  }
}
