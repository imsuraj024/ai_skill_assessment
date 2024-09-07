class Question {
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;

  Question(
      {required this.question,
      required this.options,
      required this.correctIndex,
      required this.explanation});

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options: List<String>.from(json['options']),
      correctIndex: json['correct_answer'],
      explanation: json['explanation'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'question': question,
      'options': options,
      'correct_answer': correctIndex,
      'explanation': explanation,
    };
  }
}
