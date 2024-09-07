import 'package:skill_assessment/dio_client.dart';
import 'package:skill_assessment/question/data/repository_impl/question_repo_impl.dart';
import 'package:skill_assessment/question/domain/repository/question_repo.dart';
import 'package:skill_assessment/question/domain/usecase/question_usecase.dart';
import 'package:skill_assessment/question/presentation/bloc/question_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt locator = GetIt.instance;

Future<void> setupServiceLocator() async {
  locator.registerLazySingleton<DioClient>(() => DioClient());

  locator.registerLazySingleton<QuestionRepo>(
      () => QuestionRepoImpl(dio: locator<DioClient>()));

  locator.registerLazySingleton<QuestionUsecase>(
      () => QuestionUsecase(locator<QuestionRepo>()));

  locator.registerFactory<QuestionBloc>(
      () => QuestionBloc(locator<QuestionUsecase>()));
}
