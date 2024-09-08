import 'dart:async';

import 'package:ai_skill_assessment/modules/splash/domain/usecase/splash_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SplashUsecase _splashUsecase;
  SplashBloc(this._splashUsecase) : super(SplashIntial()) {
    on<FetchFirebaseData>(_fetchFirebaseData);
  }

  FutureOr<void> _fetchFirebaseData(
      FetchFirebaseData event, Emitter<SplashState> emit) async {
    emit(SplashLoading());
    await Future.delayed(const Duration(seconds: 5)).then(
      (value) async {
        await _splashUsecase.fetchModelAndKey();
        await _splashUsecase.fetchLevelParams();
      },
    );
    emit(SplashLoaded());
  }
}
