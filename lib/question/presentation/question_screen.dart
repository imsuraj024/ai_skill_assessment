import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_skill_assessment/loading/question_loading.dart';
import 'package:ai_skill_assessment/question/presentation/bloc/question_bloc.dart';
import 'package:ai_skill_assessment/service_locator.dart';
import 'package:ai_skill_assessment/styles/app_colors.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({super.key});

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final bloc = locator<QuestionBloc>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => bloc..add(const GetQuestions(level: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Skill Assessment',
          ),
        ),
        body: BlocConsumer<QuestionBloc, AssesmentState>(
          listener: (context, state) {
            if (state is QuestionErrorState) {
              if (kDebugMode) {
                print(state.message);
              }
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is QuestionLoadingState) {
              return const QuestionLoading();
            } else if (state is QuestionLoadedState) {
              final currentQuestion =
                  state.questions[state.currentQuestionIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 30.0),
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
                          ...currentQuestion.options.asMap().entries.map(
                                (e) => _buildOption(
                                  e.key,
                                  e.value,
                                  state.selectedAnswers[
                                      state.currentQuestionIndex],
                                  state.currentQuestionIndex,
                                  state.phase,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  _buildSubmitButton(state.currentQuestionIndex),
                ],
              );
            } else if (state is AssesmentCompleteState) {
              return const Center(child: Text('Assessment Completed!'));
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _buildLevel(String level) {
    return Text(
      level,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: appBlack,
      ),
    );
  }

  Widget _buildQuestionNumber(String questionNumber) {
    return Text(
      'Question : $questionNumber',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18,
        color: appBlack,
      ),
    );
  }

  Widget _buildQuestion(String question) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
      child: Text(
        question,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: appBlack,
        ),
      ),
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
      title: Text(option),
      value: index,
      groupValue: selectedAnswer,
      onChanged: (int? value) {
        bloc.add(SelectAnswer(currentQuestionIndex, value!, level));
      },
    );
  }

  Widget _buildSubmitButton(int currentQuestionIndex) {
    return Container(
      width: double.infinity,
      height: 90,
      padding: const EdgeInsets.all(20.0),
      child: ElevatedButton(
        onPressed: () {
          bloc.add(NextQuestion(currentQuestionIndex));
        },
        child: const Text(
          'Next',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
