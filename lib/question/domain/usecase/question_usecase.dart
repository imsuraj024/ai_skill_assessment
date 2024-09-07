import 'package:skill_assessment/question/data/model/question_model.dart';
import 'package:skill_assessment/question/domain/repository/question_repo.dart';
import 'package:skill_assessment/usecase.dart';

class QuestionUsecase
    extends UsecaseWithParams<List<Question>, FetchQuestionParams> {
  final QuestionRepo questionRepo;

  QuestionUsecase(this.questionRepo);

  @override
  Future<List<Question>> call(FetchQuestionParams params) async {
    return await questionRepo.fetchQuestions(params.prompt);
  }
}

class FetchQuestionParams {
  final String prompt;
  const FetchQuestionParams(this.prompt);
}
