String model = '';
String apiKey = '';
Map<String, dynamic> beginner = {};
Map<String, dynamic> intermediate = {};
Map<String, dynamic> advanced = {};
Map<String, dynamic> expert = {};
double beginnerPercentage = 0.0;
double intermediatePercentage = 0.0;
double advancedPercentage = 0.0;
double expertPercentage = 0.0;

String generatePrompt(
    int questionCount, String topic, String level, String role, String focus) {
  return "Create $questionCount unique multiple-choice questions on the topic of $topic at a $level level. "
      "The questions should assess the suitability of a candidate for the role of a $role, focusing on $focus. "
      "Ensure each question has 4 answer choices, with one correct answer. "
      "Each question should follow the JSON schema provided below: "
      "{ \"question\": \"string\", \"options\": [\"string\", \"string\", \"string\", \"string\"], "
      "\"correct_answer\": int (Range 0 - 3), \"explanation\": \"string\", \"weightage\": int }. "
      "Return the result as an array of questions in JSON format. Rephrase questions or generate entirely new ones "
      "on each execution to maintain uniqueness and avoid repetition.";
}
