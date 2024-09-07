part of 'question_bloc.dart';

abstract class QuestionEvent extends Equatable {
  const QuestionEvent();

  @override
  List<Object> get props => [];
}

class GetQuestions extends QuestionEvent {
  final int level;

  const GetQuestions({required this.level});

  @override
  List<Object> get props => [level];
}

class SelectAnswer extends QuestionEvent {
  final int questionIndex;
  final int selectedAnswer;
  final String level;

  const SelectAnswer(this.questionIndex, this.selectedAnswer, this.level);

  @override
  List<Object> get props => [questionIndex, selectedAnswer, level];
}

class NextQuestion extends QuestionEvent {
  final int questionIndex;

  const NextQuestion(this.questionIndex);

  @override
  List<Object> get props => [questionIndex];
}
