part of 'result_bloc.dart';

abstract class ResultState extends Equatable {
  const ResultState();

  @override
  List<Object> get props => [];
}

class ResultInitial extends ResultState {}
