part of 'splash_bloc.dart';

abstract class SplashState {}

class SplashIntial extends SplashState {}

class SplashLoading extends SplashState {}

class SplashLoaded extends SplashState {
  SplashLoaded();
}

class SplashError extends SplashState {
  final String error;

  SplashError(this.error);
}
