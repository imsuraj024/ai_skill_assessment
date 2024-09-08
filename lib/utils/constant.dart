String model = '';
String apiKey = '';
String beginner = '';
String intermediate = '';
String advanced = '';
String expert = '';
double beginnerPercentage = 0.0;
double intermediatePercentage = 0.0;
double advancedPercentage = 0.0;
double expertPercentage = 0.0;
String schema =
    'Each question should follow the JSON schema provided below. Return the result as an array of questions in JSON format. { "question": "string", "options": ["string", "string", "string", "string"], "correct_answer": int (Range 0 - 3), "explanation": "string", "weightage": int } }';
