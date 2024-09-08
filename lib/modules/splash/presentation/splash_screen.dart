import 'package:ai_skill_assessment/config/app_routes.dart';
import 'package:ai_skill_assessment/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:ai_skill_assessment/config/service_locator.dart';
import 'package:ai_skill_assessment/styles/app_assests.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    appLogo,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'AI Skill Assessment',
                      style: TextStyle(
                        color: appWhite,
                        letterSpacing: 2.0,
                        fontSize: 24,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Powered by Generative AI',
                          style: TextStyle(
                            color: appWhite.withOpacity(0.7),
                            fontSize: 16,
                            letterSpacing: 1.0,
                            fontFamily: GoogleFonts.montserrat().fontFamily,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Image.asset(
                          appGenAi,
                          height: 18,
                          width: 18,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(appWhite),
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      'Please wait while we load the assessment...',
                      style: TextStyle(
                        color: appWhite.withOpacity(0.7),
                        fontSize: 16,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
