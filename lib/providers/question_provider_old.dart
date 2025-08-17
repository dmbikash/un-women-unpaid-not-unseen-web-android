// import 'package:flutter/material.dart';
// import '../models/question.dart';
// import '../data/questions.dart';
//
// class QuestionProvider_old_app extends ChangeNotifier {
//   int _currentIndex = 0;
//   final Map<String, int> _scores = {};
//   final Map<String, double> _hoursByQuestion = {};
//   bool _showHourOptions = false;
//   final Map<String, double> _selectedHoursPerQuestion = {};
//   bool _lastQuestionAnswered = false;
//
//   // Constructor to ensure questions are loaded
//   QuestionProvider_old_app() {
//     // Make sure questions are initialized
//     //print("QuestionProvider initialized with ${questions.length} questions");
//   }
//
//   // Getters
//   int get currentIndex => _currentIndex;
//
//   Map<String, int> get scores => _scores;
//
//   Map<String, double> get hoursByQuestion => _hoursByQuestion;
//
//   bool get showHourOptions => _showHourOptions;
//
//   double? get selectedHoursForCurrentQuestion {
//     // Safety check to prevent index errors
//     if (questions.isEmpty || _currentIndex < 0 ||
//         _currentIndex >= questions.length) {
//       return null;
//     }
//     return _selectedHoursPerQuestion[questions[_currentIndex].id];
//   }
//
//   Question get currentQuestion {
//     // Safety check to prevent index errors
//     if (questions.isEmpty || _currentIndex < 0 ||
//         _currentIndex >= questions.length) {
//       // If we can't access the current question, return a safe default question
//       // This prevents red screen errors but should be logged for debugging
//       //print("ERROR: Attempted to access invalid question at index $_currentIndex. Total questions: ${questions.length}");
//       return Question(
//           id: 'error',
//           questionKey: 'error',
//           logoPath: 'assets/logo/unpaid_not_unseen.png',
//           // Fallback to a known asset
//           answers: [],
//           pointValue: 0
//       );
//     }
//     return questions[_currentIndex];
//   }
//
//   int get totalQuestions => questions.length;
//
//   bool get isLastQuestion => _currentIndex == questions.length - 1;
//
//   bool get lastQuestionAnswered => _lastQuestionAnswered;
//
//   // Methods
//   void resetHourSelectionForNextQuestion() {
//     _showHourOptions = false;
//     _selectedHoursPerQuestion.clear();
//     notifyListeners();
//   }
//
//   // Reset just the current question's hour selection
//   void resetCurrentHourSelection() {
//     final String currentId = questions[_currentIndex].id;
//     _selectedHoursPerQuestion.remove(currentId);
//     notifyListeners();
//   }
//
//   void showHourSelection() {
//     _showHourOptions = true;
//     notifyListeners();
//   }
//
//   void selectHours(double hours) {
//     _selectedHoursPerQuestion[currentQuestion.id] = hours;
//     notifyListeners();
//   }
//
//   void answerQuestion(Question question, bool isYes, double? hours) {
//     // Immediately hide hour options to prevent UI glitches
//     _showHourOptions = false;
//
//     // Log which question is being answered
//     //print("Answering question: ${question.id}, currentIndex: $_currentIndex, total questions: ${questions.length}");
//
//     if (isYes && hours != null) {
//       // Calculate the score: baseValue * hours * 7 days per week
//       final int score = (question.pointValue * hours * 7).round();
//       _scores[question.id] = score;
//       _hoursByQuestion[question.id] = hours;
//       _selectedHoursPerQuestion[question.id] = hours;
//     } else {
//       // No score for "no" answers
//       _scores[question.id] = 0;
//       _hoursByQuestion[question.id] = 0.0;
//     }
//
//     // Check if we're on the last question (index 11)
//     if (_currentIndex == questions.length - 1) {
//       //print("Processing the last question (index: $_currentIndex)");
//
//       // Only mark as completed if:
//       // 1. It's a "No" answer (isYes is false), OR
//       // 2. It's a "Yes" answer AND hours have been selected
//       if (!isYes || (isYes && hours != null)) {
//         //print("Last question is complete - marking as answered");
//         _lastQuestionAnswered = true;
//       } else {
//         // For "Yes" without hours, we're showing hour options but not completing yet
//         //print("Showing hour options for last question - not complete yet");
//         _lastQuestionAnswered = false;
//       }
//     } else {
//       // Move to next question
//       _currentIndex++;
//       //print("Moving to next question index: $_currentIndex");
//       resetHourSelectionForNextQuestion();
//     }
//
//     notifyListeners();
//   }
//
//   int calculateTotalScore() {
//     return _scores.values.fold(0, (sum, score) => sum + score);
//   }
//
//   void resetQuiz() {
//     _currentIndex = 0;
//     _scores.clear();
//     _hoursByQuestion.clear();
//     _selectedHoursPerQuestion.clear();
//     _lastQuestionAnswered = false;
//     resetHourSelectionForNextQuestion();
//     notifyListeners();
//   }
//
//   // Clear all data when finished
//   void clearAllData() {
//     _currentIndex = 0;
//     _scores.clear();
//     _hoursByQuestion.clear();
//     _showHourOptions = false;
//     _selectedHoursPerQuestion.clear();
//     _lastQuestionAnswered = false;
//     notifyListeners();
//   }
// }
