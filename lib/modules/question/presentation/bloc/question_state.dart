part of 'question_bloc.dart';

abstract class AssesmentState extends Equatable {
  const AssesmentState();

  @override
  List<Object> get props => [];
}

class AssesmentInitialState extends AssesmentState {
  const AssesmentInitialState();
}

class QuestionLoadingState extends AssesmentState {
  const QuestionLoadingState();
}

class QuestionLoadedState extends AssesmentState {
  final List<Question> questions;
  final Map<int, int> selectedAnswers;
  final int currentQuestionIndex;
  final String phase;

  const QuestionLoadedState({
    required this.questions,
    required this.selectedAnswers,
    required this.currentQuestionIndex,
    required this.phase,
  });

  QuestionLoadedState copyWith({
    List<Question>? questions,
    Map<int, int>? selectedAnswers,
    int? currentQuestionIndex,
    String? phase,
  }) {
    return QuestionLoadedState(
      questions: questions ?? this.questions,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
      phase: phase ?? this.phase,
    );
  }

  @override
  List<Object> get props =>
      [questions, selectedAnswers, currentQuestionIndex, phase];
}

class QuestionErrorState extends AssesmentState {
  final String message;
  final int level;

  const QuestionErrorState(this.message, this.level);

  @override
  List<Object> get props => [message, level];
}

class AssesmentResultState extends AssesmentState {
  const AssesmentResultState();

  @override
  List<Object> get props => [];
}
