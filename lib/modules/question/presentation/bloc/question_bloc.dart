import 'dart:async';
import 'package:ai_skill_assessment/utils/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_skill_assessment/modules/question/data/model/question_model.dart';
import 'package:ai_skill_assessment/modules/question/domain/usecase/question_usecase.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toastification/toastification.dart';

part 'question_event.dart';
part 'question_state.dart';

class QuestionBloc extends Bloc<QuestionEvent, AssesmentState> {
  final QuestionUsecase questionUsecase;
  int level = 1;

  QuestionBloc(this.questionUsecase) : super(const AssesmentInitialState()) {
    on<GetQuestions>(_getQuestions);
    on<SelectAnswer>(_selectAnswer);
    on<NextQuestion>(_nextQuestion);
  }

  FutureOr<void> _getQuestions(
      GetQuestions event, Emitter<AssesmentState> emit) async {
    try {
      emit(const QuestionLoadingState());
      final questions = await _fetchQuestionsByLevel(event.level);
      emit(QuestionLoadedState(
        questions: questions,
        selectedAnswers: const {},
        currentQuestionIndex: 0,
        phase: _fetchPhaseByLevel(event.level),
      ));
    } catch (e) {
      emit(QuestionErrorState('Failed to load questions: $e'));
    }
  }

  void _selectAnswer(SelectAnswer event, Emitter<AssesmentState> emit) {
    if (state is QuestionLoadedState) {
      final currentState = state as QuestionLoadedState;
      final updatedAnswers = {...currentState.selectedAnswers}
        ..[event.questionIndex] = event.selectedAnswer;

      emit(currentState.copyWith(
        selectedAnswers: updatedAnswers,
      ));
    }
  }

  void _nextQuestion(NextQuestion event, Emitter<AssesmentState> emit) {
    if (state is QuestionLoadedState) {
      final currentState = state as QuestionLoadedState;
      final selectedAnswer =
          currentState.selectedAnswers[currentState.currentQuestionIndex];

      if (selectedAnswer == null) {
        _showToastMessage(
          'Please select an answer for question ${currentState.currentQuestionIndex + 1}',
          ToastificationType.error,
        );
      } else {
        _evaluateAnswer(currentState, selectedAnswer);

        final isLastQuestion = _isLastQuestion(
          currentState.currentQuestionIndex,
          currentState.questions.length,
        );

        if (isLastQuestion) {
          _handleLevelProgression(emit);
        } else {
          emit(currentState.copyWith(
            currentQuestionIndex: currentState.currentQuestionIndex + 1,
          ));
        }
      }
    }
  }

  void _evaluateAnswer(QuestionLoadedState currentState, int selectedAnswer) {
    final currentQuestion =
        currentState.questions[currentState.currentQuestionIndex];
    final correctAnswer = currentQuestion.correctIndex;
    final explanation = currentQuestion.explanation;

    if (kDebugMode) {
      print('Question: ${currentQuestion.question}');
      print('Selected Answer: ${currentQuestion.options[selectedAnswer]}');
      print('Correct Answer: ${currentQuestion.options[correctAnswer]}');
      print('Explanation: $explanation');
    }

    if (selectedAnswer == correctAnswer) {
      _showToastMessage(
        'Correct! Well done! 🎉 You’re on the right track',
        ToastificationType.success,
      );
    } else {
      _showToastMessage(
        'Oops! ❌ The correct answer is ${currentQuestion.options[correctAnswer]}',
        ToastificationType.error,
      );
    }
  }

  bool _isLastQuestion(int currentIndex, int totalQuestions) {
    return currentIndex == totalQuestions - 1;
  }

  void _handleLevelProgression(Emitter<AssesmentState> emit) {
    if (level < 4) {
      level++;
      add(GetQuestions(level: level));
    } else {
      emit(const AssesmentCompleteState());
    }
  }

  Future<List<Question>> _fetchQuestionsByLevel(int level) async {
    switch (level) {
      case 1:
        return questionUsecase.call(FetchQuestionParams('$beginner $schema'));
      case 2:
        return questionUsecase
            .call(FetchQuestionParams('$intermediate $schema'));
      case 3:
        return questionUsecase.call(FetchQuestionParams('$advanced $schema'));
      case 4:
        return questionUsecase.call(FetchQuestionParams('$expert $schema'));
      default:
        throw Exception("Invalid level");
    }
  }

  String _fetchPhaseByLevel(int level) {
    switch (level) {
      case 1:
        return 'Phase : 1';
      case 2:
        return 'Phase : 2';
      case 3:
        return 'Phase : 3';
      case 4:
        return 'Phase : 4';
      default:
        throw Exception("Invalid level");
    }
  }

  void _showToastMessage(String message, ToastificationType type) {
    toastification.show(
      autoCloseDuration: const Duration(seconds: 2),
      title: Text(
        message,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 16,
          height: 1.2,
          fontFamily: GoogleFonts.montserrat().fontFamily,
        ),
      ),
      closeOnClick: false,
      type: type,
      style: ToastificationStyle.flatColored,
      showIcon: false,
      closeButtonShowType: CloseButtonShowType.none,
    );
  }
}
