import 'package:ai_skill_assessment/config/app_routes.dart';
import 'package:ai_skill_assessment/utils/constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_skill_assessment/modules/widget/question_loading.dart';
import 'package:ai_skill_assessment/modules/question/presentation/bloc/question_bloc.dart';
import 'package:ai_skill_assessment/config/service_locator.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final QuestionBloc bloc = locator<QuestionBloc>();

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(const GetQuestions(level: 1)),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appBlack,
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text(
            'AI Skill Assessment',
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 20,
              letterSpacing: 2.0,
              color: appWhite,
              height: 1.5,
              fontFamily: GoogleFonts.roboto().fontFamily,
            ),
          ),
        ),
        body: BlocConsumer<QuestionBloc, AssesmentState>(
          listener: (context, state) async {
            if (state is QuestionErrorState) {
              if (kDebugMode) {
                print(state.message);
              }
              bloc.add(GetQuestions(level: state.level));
            }

            // if (state is MoveToResult) {
            //   if (state.level < 4) {
            //     ResultScreenArguments args = ResultScreenArguments(
            //       percentage: state.percentage,
            //       correctAnswerCount: state.correctAnswerCount,
            //       totalQuestionsCount: state.totalQuestionsCount,
            //       level: state.level,
            //     );

            //     final int result = await Navigator.pushNamed(
            //         context, AppRoutes.result,
            //         arguments: args) as int;
            //     bloc.add(GetQuestions(level: result));
            //   } else {
            //     expertPercentage = state.percentage;
            //     await Navigator.pushNamed(context, AppRoutes.finalResult);
            //     bloc.add(const GetQuestions(level: 1));
            //   }
            // }
          },
          builder: (context, state) {
            if (state is QuestionLoadingState) {
              return const QuestionLoading();
            } else if (state is QuestionLoadedState) {
              return _buildLoadedState(state);
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildLoadedState(QuestionLoadedState state) {
    final currentQuestion = state.questions[state.currentQuestionIndex];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildLevel(state.phase),
                _buildQuestionNumber(
                    '${state.currentQuestionIndex + 1}/${state.questions.length}'),
              ],
            ),
          ),
          const Divider(),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildQuestion(currentQuestion.question),
                  _buildOptionsList(currentQuestion.options, state,
                      state.currentQuestionIndex),
                ],
              ),
            ),
          ),
          _buildSubmitButton(state.currentQuestionIndex),
        ],
      ),
    );
  }

  Widget _buildLevel(String level) {
    return Text(
      level,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: appAnswer,
        height: 1.5,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }

  Widget _buildQuestionNumber(String questionNumber) {
    return Text(
      'Question: $questionNumber',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 18,
        color: appAnswer,
        height: 1.5,
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 20,
          color: appQuestion,
          height: 1.5,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
    );
  }

  Widget _buildOptionsList(
      List<String> options, QuestionLoadedState state, int currentIndex) {
    return ListView.builder(
      shrinkWrap: true, // Prevents ListView from expanding indefinitely
      physics: const NeverScrollableScrollPhysics(),
      itemCount: options.length,
      itemBuilder: (context, index) {
        return _buildOption(
          index,
          options[index],
          state.selectedAnswers[currentIndex],
          currentIndex,
          state.phase,
        );
      },
    );
  }

  Widget _buildOption(
    int index,
    String option,
    int? selectedAnswer,
    int currentQuestionIndex,
    String level,
  ) {
    return RadioListTile<int>(
      title: Text(
        option,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 18,
          color: appAnswer,
          height: 1.5,
          fontFamily: GoogleFonts.roboto().fontFamily,
        ),
      ),
      activeColor: appBlack,
      value: index,
      groupValue: selectedAnswer,
      onChanged: (int? value) {
        bloc.add(
          SelectAnswer(
              questionIndex: currentQuestionIndex,
              selectedAnswer: value!,
              level: level),
        );
      },
    );
  }

  Widget _buildSubmitButton(int currentQuestionIndex) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          bloc.add(NextQuestion(questionIndex: currentQuestionIndex));
        },
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
        child: const Text(
          'Next',
        ),
      ),
    );
  }
}
