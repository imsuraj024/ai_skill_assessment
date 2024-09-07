import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_skill_assessment/prompts.dart';
import 'package:ai_skill_assessment/question/data/model/question_model.dart';
import 'package:ai_skill_assessment/question/domain/usecase/question_usecase.dart';
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
      emit(
        QuestionLoadedState(
          questions: questions,
          selectedAnswers: const {},
          currentQuestionIndex: 0,
          phase: _fetchPhaseByLevel(event.level),
        ),
      );
    } catch (e) {
      emit(QuestionErrorState('Failed to load questions: ${e.toString()}'));
    }
  }

  void _selectAnswer(SelectAnswer event, Emitter<AssesmentState> emit) {
    if (state is QuestionLoadedState) {
      final currentState = state as QuestionLoadedState;

      final updatedAnswers = Map<int, int>.from(currentState.selectedAnswers)
        ..[event.questionIndex] = event.selectedAnswer;

      emit(QuestionLoadedState(
        questions: currentState.questions,
        selectedAnswers: updatedAnswers,
        currentQuestionIndex: currentState.currentQuestionIndex,
        phase: event.level,
      ));
    }
  }

  void _nextQuestion(NextQuestion event, Emitter<AssesmentState> emit) {
    if (state is QuestionLoadedState) {
      final currentState = state as QuestionLoadedState;

      final selectedAnswer =
          currentState.selectedAnswers[currentState.currentQuestionIndex];

      if (kDebugMode) {
        print('---------- Output -----------');
        print(
            'Question : ${currentState.questions[currentState.currentQuestionIndex].question}');
        print(
            'Selected Answer: ${selectedAnswer == null ? 'No answer selected' : currentState.questions[currentState.currentQuestionIndex].options[selectedAnswer]} ');
        print(
            'Correct Answer: ${currentState.questions[currentState.currentQuestionIndex].options[currentState.questions[currentState.currentQuestionIndex].correctIndex]}');
        print('---------------------');
      }

      if ((selectedAnswer ?? -1) ==
          currentState
              .questions[currentState.currentQuestionIndex].correctIndex) {
        toastification.show(
          autoCloseDuration: const Duration(seconds: 2),
          title: const Text('Correct! Well done! 🎉 You’re on the right track'),
          closeOnClick: false,
          type: ToastificationType.success,
          style: ToastificationStyle.flatColored,
          showIcon: false,
          closeButtonShowType: CloseButtonShowType.none,
        );
      } else {
        toastification.show(
          autoCloseDuration: const Duration(seconds: 2),
          title: Text(
              'Oops! ❌ The correct answer is ${currentState.questions[currentState.currentQuestionIndex].options[currentState.questions[currentState.currentQuestionIndex].correctIndex]}.'),
          closeOnClick: false,
          type: ToastificationType.error,
          style: ToastificationStyle.flatColored,
          showIcon: false,
          closeButtonShowType: CloseButtonShowType.none,
        );
      }

      final isLastQuestion = _isLastQuestion(
        currentState.currentQuestionIndex,
        currentState.questions.length,
      );

      if (isLastQuestion) {
        _handleLevelProgression(emit);
      } else {
        emit(QuestionLoadedState(
          questions: currentState.questions,
          selectedAnswers: currentState.selectedAnswers,
          currentQuestionIndex: currentState.currentQuestionIndex + 1,
          phase: currentState.phase,
        ));
      }
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

  Future<List<Question>> _fetchQuestionsByLevel(int level) async {
    switch (level) {
      case 1:
        return questionUsecase.call(const FetchQuestionParams(beginner));
      case 2:
        return questionUsecase.call(const FetchQuestionParams(intermediate));
      case 3:
        return questionUsecase.call(const FetchQuestionParams(advanced));
      case 4:
        return questionUsecase.call(const FetchQuestionParams(expert));
      default:
        throw Exception("Invalid level");
    }
  }
}
