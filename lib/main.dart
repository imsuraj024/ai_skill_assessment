import 'package:ai_skill_assessment/config/app_routes.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:ai_skill_assessment/config/service_locator.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:toastification/toastification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyDFQV3DCR-bSESxPUJSqpBcakIGB6taQaI',
      appId: '1:919770462103:android:ea23909c4a30a2916476d2',
      messagingSenderId: '919770462103',
      projectId: 'ai-skill-assessment',
      storageBucket: 'ai-skill-assessment.appspot.com',
    ),
  );
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
        title: 'AI Skill Assessment',
        theme: ThemeData(
          scaffoldBackgroundColor: appWhite,
          useMaterial3: true,
        ),
        initialRoute: AppRoutes.splash,
        onGenerateRoute: AppRoutes.generateRoutes,
      ),
    );
  }
}
