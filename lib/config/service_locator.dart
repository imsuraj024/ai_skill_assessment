import 'package:ai_skill_assessment/modules/splash/domain/usecase/splash_usecase.dart';
import 'package:ai_skill_assessment/modules/splash/presentation/bloc/splash_bloc.dart';
import 'package:ai_skill_assessment/network/dio_client.dart';
import 'package:ai_skill_assessment/modules/question/data/repository_impl/question_repo_impl.dart';
import 'package:ai_skill_assessment/modules/question/domain/repository/question_repo.dart';
import 'package:ai_skill_assessment/modules/question/domain/usecase/question_usecase.dart';
import 'package:ai_skill_assessment/modules/question/presentation/bloc/question_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  locator.registerLazySingleton<DioClient>(() => DioClient());

  locator.registerLazySingleton<SplashUsecase>(() => SplashUsecase());

  locator
      .registerFactory<SplashBloc>(() => SplashBloc(locator<SplashUsecase>()));

  locator.registerLazySingleton<QuestionRepo>(
      () => QuestionRepoImpl(dio: locator<DioClient>()));

  locator.registerLazySingleton<QuestionUsecase>(
      () => QuestionUsecase(locator<QuestionRepo>()));

  locator.registerFactory<QuestionBloc>(
      () => QuestionBloc(locator<QuestionUsecase>()));
}
