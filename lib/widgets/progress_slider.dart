import 'package:flutter/material.dart';
import '../design/themes/colors.dart';
import '../services/languages.dart';

class ProgressSlider extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const ProgressSlider({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    // Get progress text from language file
    final String progressText = i18n[language]?['unpaid_work_calculator']?['progress'] ??
        'Question %current of %total';
    final String formattedProgressText = progressText
        .replaceAll('%current', currentQuestion.toString())
        .replaceAll('%total', totalQuestions.toString());

    return Column(
      children: [
        // Progress Text
        Text(
          formattedProgressText,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14.0,
          ),
        ),

        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.01),

        // Progress Bar
        Container(
          height: 6.0,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: currentQuestion / totalQuestions,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.7),
                  ],
                ),
                borderRadius: BorderRadius.circular(3.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
