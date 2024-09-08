import 'package:ai_skill_assessment/config/app_routes.dart';
import 'package:ai_skill_assessment/modules/result/presentation/bloc/result_bloc.dart';
import 'package:ai_skill_assessment/styles/app_assests.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends StatefulWidget {
  final ResultScreenArguments args;
  const ResultScreen({super.key, required this.args});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  final ResultBloc bloc = ResultBloc();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'Skill Assessment',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0,
              fontSize: 20,
              color: appQuestion,
              height: 1.5,
              fontFamily: GoogleFonts.roboto().fontFamily,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocBuilder(
            bloc: bloc
              ..add(
                  ResultLoadedEvent(widget.args.percentage, widget.args.level)),
            builder: (context, state) {
              if (state is ResultLoaded) {
                return Column(
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
                        '${bloc.fetchPhaseByLevel(widget.args.level)}  Assessment',
                        style: TextStyle(
                          color: appBlack,
                          fontSize: 24,
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              'Your Score - ${widget.args.correctAnswerCount} / ${widget.args.totalQuestionsCount}',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              'Your percentage - ${widget.args.percentage} %',
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Text(
                              state.message,
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
                );
              }
              return const SizedBox();
            },
          ),
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
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: TextStyle(
            fontFamily: GoogleFonts.roboto().fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Next',
        ),
      ),
    );
  }
}
