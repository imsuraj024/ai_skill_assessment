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

  const SelectAnswer({
    required this.questionIndex,
    required this.selectedAnswer,
    required this.level,
  });

  @override
  List<Object> get props => [questionIndex, selectedAnswer, level];
}

class NextQuestion extends QuestionEvent {
  final int questionIndex;

  const NextQuestion({required this.questionIndex});

  @override
  List<Object> get props => [questionIndex];
}

