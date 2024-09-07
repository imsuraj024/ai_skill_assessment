const String beginner = '''
Generate exactly 10 unique multiple-choice questions focused on basic Dart syntax, simple Flutter widgets, 
and basic layout principles. Each question should be beginner-level and assess fundamental understanding 
and practical knowledge of these concepts. Each question should follow this JSON schema: 
Question = {"question": "string", "options":["string","string","string","string"], "correct_answer": int}Return: Array<Question>. 
The questions should cover fundamental concepts and practical knowledge, ensuring that each question is unique. 
Provide a complete array of questions, where each question includes four answer options with one correct answer 
and three distractors.
''';

const String intermediate = '''
Generate exactly 15 unique multiple-choice intermediate-level questions related to Flutter. The questions should 
cover the following topics: state management solutions, navigation, complex widget properties, layout customization, 
and basic animations. Each question should include four answer options, with one correct answer and three distractors. 
Each question should follow this JSON schema: 
Question = {"question": "string", "options":["string","string","string","string"], "correct_answer": int}Return: Array<Question>. 
Ensure that the output adheres to this schema and contains exactly 15 questions. Each question should be unique, and 
the correct answer should be properly identified by its index in the options array.
''';

const String advanced = '''
Generate exactly 15 unique, advanced-level multiple-choice questions that evaluate knowledge in the following areas: 
advanced state management, custom animations, performance optimization, complex state management scenarios, and 
working with REST APIs and local databases. Each question should be challenging and test problem-solving 
and optimization skills. Each question must follow this JSON schema: 
Question = {"question": "string", "options":["string","string","string","string"], "correct_answer": int}Return: Array<Question>. 
Ensure that each set of answers includes one correct answer and three distractors. The response should be an array of 
15 unique questions, formatted according to the given schema. Avoid including more or fewer questions.
''';

const String expert = '''
Generate exactly 10 unique multiple-choice questions focusing on advanced architectural patterns, deep understanding of 
Flutter internals, platform-specific integrations, complex UI and UX challenges, and testing and debugging strategies. 
Each question should be expert-level, assessing mastery and the ability to solve intricate problems. Each question 
must include 4 answer options, with only one correct answer and three distractors. Follow the JSON schema exactly 
as shown below: 
Question = {"question": "string", "options":["string","string","string","string"], "correct_answer": int}Return: Array<Question>. 
Ensure the that each question is unique and has 4 answer options.
One option is marked as the correct answer (indexed by an integer) and the total number of questions generated is exactly 10.
''';
