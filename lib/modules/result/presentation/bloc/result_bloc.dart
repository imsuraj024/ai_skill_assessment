import 'dart:async';

import 'package:ai_skill_assessment/utils/constant.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'result_event.dart';
part 'result_state.dart';

class ResultBloc extends Bloc<ResultEvent, ResultState> {
  ResultBloc() : super(ResultInitial()) {
    on<ResultLoadedEvent>(_resultLoadedEvent);
  }

  String _getResult(double percentage) {
    if (percentage >= 90) {
      return "Excellent work! You're a pro!";
    } else if (percentage >= 75) {
      return "Great job! You're quite skilled!";
    } else if (percentage >= 50) {
      return "Good effort! Keep practicing!";
    } else {
      return "You might need some more practice.";
    }
  }

  String fetchPhaseByLevel(int level) {
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

  FutureOr<void> _resultLoadedEvent(
      ResultLoadedEvent event, Emitter<ResultState> emit) {
    if (event.level == 1) {
      beginnerPercentage = event.percentage;
    } else if (event.level == 2) {
      intermediatePercentage = event.percentage;
    } else if (event.level == 3) {
      advancedPercentage = event.percentage;
    } else {
      expertPercentage = event.percentage;
    }
    emit(ResultLoaded(
        message: _getResult(event.percentage), level: event.level));
  }
}
