import '../models/question.dart';
import '../services/question_service.dart';

// Use the question service to get questions
List<Question> getQuestions() {
  // Force evaluation and return
  final questionList = QuestionService.getQuestions();
  return questionList;
}

// Lazy-loaded questions list
final List<Question> questions = getQuestions();
