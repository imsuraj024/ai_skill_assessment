import 'package:ai_skill_assessment/modules/question/data/model/question_model.dart';

abstract class QuestionRepo {
  Future<List<Question>> fetchQuestions(String prompt);
}
