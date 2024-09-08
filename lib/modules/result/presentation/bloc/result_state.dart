part of 'result_bloc.dart';

abstract class ResultState extends Equatable {
  @override
  List<Object> get props => [];
}

class ResultInitial extends ResultState {}

class ResultLoading extends ResultState {}

class ResultLoaded extends ResultState {
  final String message;
  final int level;
  ResultLoaded({required this.message, required this.level});

  @override
  List<Object> get props => [message];
}

class ResultError extends ResultState {
  final String message;
  ResultError({required this.message});

  @override
  List<Object> get props => [message];
}
