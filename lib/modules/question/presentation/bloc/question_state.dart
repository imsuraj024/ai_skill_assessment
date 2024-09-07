part of 'question_bloc.dart';

abstract class AssesmentState extends Equatable {
  const AssesmentState();

  @override
  List<Object?> get props => [];
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

  @override
  List<Object?> get props =>
      [questions, selectedAnswers, currentQuestionIndex, phase];
}

class QuestionErrorState extends AssesmentState {
  final String message;
  const QuestionErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class AnswerState extends AssesmentState {
  final String message;
  final Color color;
  const AnswerState(this.message, this.color);
}

class AssesmentCompleteState extends AssesmentState {
  const AssesmentCompleteState();
}
