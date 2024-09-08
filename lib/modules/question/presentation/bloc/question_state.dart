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

  const QuestionErrorState(this.message);

  @override
  List<Object> get props => [message];
}

class MoveToResult extends AssesmentState {
  final double percentage;
  final int correctAnswerCount;
  final int totalQuestionsCount;
  final int level;
  const MoveToResult(this.percentage, this.correctAnswerCount,
      this.totalQuestionsCount, this.level);

  @override
  List<Object> get props =>
      [percentage, correctAnswerCount, totalQuestionsCount, level];
}
