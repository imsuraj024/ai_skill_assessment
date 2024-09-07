import 'package:ai_skill_assessment/modules/question/data/model/question_model.dart';
import 'package:ai_skill_assessment/modules/question/domain/repository/question_repo.dart';
import 'package:ai_skill_assessment/config/usecase.dart';

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
