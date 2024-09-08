import 'package:ai_skill_assessment/modules/result/presentation/bloc/result_bloc.dart';
import 'package:ai_skill_assessment/styles/app_assests.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class FinalResultScreen extends StatefulWidget {
  const FinalResultScreen({
    super.key,
  });

  @override
  State<FinalResultScreen> createState() => _FinalResultScreenState();
}

class _FinalResultScreenState extends State<FinalResultScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: appBlack,
        title: Text(
          'Skill Assessment',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            letterSpacing: 2.0,
            fontSize: 20,
            color: appWhite,
            height: 1.5,
            fontFamily: GoogleFonts.roboto().fontFamily,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              appResult,
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Text(
                'Final Assessment',
                style: TextStyle(
                  color: appBlack,
                  fontSize: 24,
                  letterSpacing: 2.0,
                  fontFamily: GoogleFonts.montserrat().fontFamily,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: appBlack.withOpacity(0.7),
                        fontSize: 16,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: appBlack.withOpacity(0.7),
                        fontSize: 16,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Text(
                      '',
                      style: TextStyle(
                        color: appBlack.withOpacity(0.7),
                        fontSize: 16,
                        fontFamily: GoogleFonts.montserrat().fontFamily,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: appBlack,
          foregroundColor: appWhite,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 18,
            letterSpacing: 1.0,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text('Finish'),
      ),
    );
  }
}
