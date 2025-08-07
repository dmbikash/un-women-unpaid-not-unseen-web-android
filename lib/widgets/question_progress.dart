import 'package:flutter/material.dart';
import '../design/themes/colors.dart';
import '../services/languages.dart';
import 'package:provider/provider.dart';
import '../services/language_service.dart';

class QuestionProgress extends StatelessWidget {
  final int currentQuestion;
  final int totalQuestions;

  const QuestionProgress({
    super.key,
    required this.currentQuestion,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    // Calculate responsive sizes
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final langService = Provider.of<LanguageServiceMobile>(context);

    // Get translated text with placeholders replaced
    final String progressText =
        i18n[langService
            .currentLanguage]?['question_progress']?['question_of'] ??
        'Question {{current}} of {{total}}';
    final String displayText = progressText
        .replaceAll('{{current}}',
        langService.convertNumberToBengali(currentQuestion.toString()))
        .replaceAll('{{total}}',
        langService.convertNumberToBengali(totalQuestions.toString()));

    return Column(
      children: [
        // Progress Text
        Text(
          displayText,
          style: TextStyle(
            color: AppColors.black,
            fontSize: screenWidth * 0.045, // 3.5% of screen width
            fontWeight: FontWeight.w500,
          ),
        ),

        SizedBox(height: screenHeight * 0.01), // 1% of screen height
        // Box-style progress indicator
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            12,
            (index) => Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.005),
              // 0.5% of width
              width: screenWidth * 0.04,
              // 4% of width
              height: screenHeight * 0.007,
              // 0.7% of height
              decoration: BoxDecoration(
                color:
                    index < currentQuestion
                        ? AppColors.primary
                        : Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(screenWidth * 0.008),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
