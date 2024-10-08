import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ai_skill_assessment/utils/constant.dart';
import 'package:ai_skill_assessment/network/dio_client.dart';
import 'package:ai_skill_assessment/modules/question/data/model/question_model.dart';
import 'package:ai_skill_assessment/modules/question/domain/repository/question_repo.dart';

class QuestionRepoImpl implements QuestionRepo {
  final DioClient dio;

  QuestionRepoImpl({required this.dio});

  @override
  Future<List<Question>> fetchQuestions(String prompt) async {
    try {
      final response = await dio.post(
        '/v1beta/models/$model:generateContent?key=$apiKey',
        data: json.encode({
          "contents": [
            {
              "role": "user",
              "parts": [
                {
                  "text": prompt,
                }
              ]
            }
          ],
          "generationConfig": {
            "temperature": 1,
            "topK": 64,
            "topP": 0.95,
            "maxOutputTokens": 8192,
            "responseMimeType": "application/json"
          }
        }),
        options: Options(headers: {
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> parsedJson =
            jsonDecode(jsonEncode(response.data));
        String text =
            parsedJson['candidates'][0]['content']['parts'][0]['text'];

        List<dynamic> questionsJson = jsonDecode(text);
        List<Question> questions =
            questionsJson.map((json) => Question.fromJson(json)).toList();
        return questions;
      } else {
        throw Exception(
            'Failed to load questions. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching questions: $e');
    }
  }
}
