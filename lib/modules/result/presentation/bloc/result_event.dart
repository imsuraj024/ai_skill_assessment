part of 'result_bloc.dart';

abstract class ResultEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class ResultLoadedEvent extends ResultEvent {
  final double percentage;
  final int level;

  ResultLoadedEvent(this.percentage, this.level);

  @override
  List<Object?> get props => [percentage];
}

class NextPhaseEvent extends ResultEvent {
  NextPhaseEvent();
}
