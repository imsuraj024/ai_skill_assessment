import 'package:ai_skill_assessment/config/app_routes.dart';
import 'package:ai_skill_assessment/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:ai_skill_assessment/config/service_locator.dart';
import 'package:ai_skill_assessment/styles/app_assets.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final splashBloc = locator<SplashBloc>();
    return BlocProvider(
      create: (context) => splashBloc,
      child: Scaffold(
        backgroundColor: appBlack,
        body: BlocConsumer(
          bloc: splashBloc..add(FetchFirebaseData()),
          listener: (context, state) {
            if (state is SplashLoaded) {
              Navigator.pushReplacementNamed(context, AppRoutes.question);
            }
          },
          builder: (context, state) {
            return Center(
                child: RiveAnimation.asset(
              splashLoader,
            ));
          },
        ),
      ),
    );
  }
}
