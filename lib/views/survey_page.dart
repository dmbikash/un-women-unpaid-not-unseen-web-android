// import 'package:flutter/material.dart';
// import '../design/themes/colors.dart';
// import '../design/text/textStyles.dart';
// import '../services/languages.dart';
// import '../models/question.dart';
// import '../widgets/question_slider.dart';
// import '../services/question_service.dart';
//
// class SurveyPage extends StatefulWidget {
//   const SurveyPage({Key? key}) : super(key: key);
//
//   @override
//   State<SurveyPage> createState() => _SurveyPageState();
// }
//
// class _SurveyPageState extends State<SurveyPage> {
//   late List<Question> _questions;
//   final Map<String, Answer> _responses = {};
//
//   @override
//   void initState() {
//     super.initState();
//     _questions = QuestionService.getQuestions();
//   }
//
//   void _handleAnswerSelected(Question question, Answer answer) {
//     setState(() {
//       _responses[question.id] = answer;
//     });
//
//     // You could automatically advance to the next question here
//     // Or calculate results when all questions are answered
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         title: Text(
//           i18n[language]?['unpaid_work_calculator']?['app_title'] ?? 'Survey',
//           style: ThemeTextStyles.heading.copyWith(color: Colors.white),
//         ),
//         backgroundColor: AppColors.primary,
//       ),
//       body: SafeArea(
//         child: QuestionSlider(
//           questions: _questions,
//           onAnswerSelected: _handleAnswerSelected,
//         ),
//       ),
//     );
//   }
// }
