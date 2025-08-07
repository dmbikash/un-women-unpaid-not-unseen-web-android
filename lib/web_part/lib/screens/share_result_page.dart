import 'package:unwomen_unpaid_not_unseen/services/language_service.dart';
import 'package:unwomen_unpaid_not_unseen/web_wrapper.dart';

import '../constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../design/themes/colors.dart';
import '../models/question.dart';
import '../services/languages.dart';
import '../services/question_service.dart';
import '../widgets/hour_chart.dart';
import '../services/language_service.dart';

class ShareResultPage extends StatelessWidget {
  final String name;
  final double totalHours;
  final double totalValue;
  final Map<String, double> selectedTasks;

  const ShareResultPage({
    Key? key,
    required this.name,
    required this.totalHours,
    required this.totalValue,
    required this.selectedTasks,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LanguageServiceMobile>(context);
    // Get the passed data from arguments
    final args = ModalRoute
        .of(context)!
        .settings
        .arguments as Map<String, dynamic>? ?? {};
    final Map<String, int> scores = args['scores'] as Map<String, int>? ?? {};
    final int totalScore = args['totalScore'] as int? ?? 0;
    final Map<String, double>? hoursByQuestion = args['hoursByQuestion'] as Map<
        String,
        double>? ?? {};
    final Map<String, String> taskNames = args['taskNames'] as Map<
        String,
        String>? ?? {};

    // Get all questions to match them with scores
    final List<Question> allQuestions = QuestionService.getQuestions();
    final Map<String, Question> questionsById = {
      for (var q in allQuestions) q.id: q
    };

    // Group active questions (with score > 0)
    final List<MapEntry<String, int>> activeScores =
    scores.entries.where((e) => e.value > 0).toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    // Check if we have any hours data
    final bool hasHourData = hoursByQuestion != null &&
        hoursByQuestion.values.any((hours) => hours > 0);

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          i18n[langService
              .currentLanguage]?['share_result_page']?['title'] ??
              'Share Your Results',
          style: AppTextStyles.h1(context, color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          // Back button
        ],
      ),
      body: WebWrapper(
        // padding: EdgeInsets.only(
        //   bottom: MediaQuery
        //       .of(context)
        //       .size
        //       .height * 0.03,
        // ),
        // physics: const ClampingScrollPhysics(),
        children: [
          // Logo Row
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery
                  .of(context)
                  .size
                  .width * 0.04,
              vertical: MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery
                  .of(context)
                  .size
                  .width * 0.01,
              vertical: MediaQuery
                  .of(context)
                  .size
                  .height * 0.015,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  spreadRadius: 1,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      '/',
                          (Route<dynamic> route) => false,
                    );
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.07,
                    width: 80,
                    decoration: BoxDecoration(
                      color: Color(0xFF228DCB,),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 4, spreadRadius: 1, offset: Offset(0, 2))],
                    ),
                    child: Icon(Icons.calculate_rounded, color:AppColors.background ,size: 40,),
                  ),
                ),
                //SizedBox(width: 10,),
                Image.asset(
                  'assets/logo/un_woman.png',
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),

          // Main Result Card
          Container(
            width: double.infinity,
            margin: EdgeInsets.fromLTRB(
              MediaQuery
                  .of(context)
                  .size
                  .width * 0.04,
              MediaQuery
                  .of(context)
                  .size
                  .height * 0.01,
              MediaQuery
                  .of(context)
                  .size
                  .width * 0.04,
              MediaQuery
                  .of(context)
                  .size
                  .height * 0.02,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.05),
              child: Column(
                children: [
                  // Unpaid not unseen logo
                  Container(
                    padding: EdgeInsets.all(MediaQuery
                        .of(context)
                        .size
                        .width * 0.025),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      'assets/logo/unpaid_not_unseen.png',
                      height: MediaQuery
                          .of(context)
                          .size
                          .width * 0.125,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03),

                  Text(
                    i18n[langService
                        .currentLanguage]?['share_result_page']?['unpaid_work_value'] ??
                        'Your Unpaid Work Value',
                    style: AppTextStyles.h1(context),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.01),

                  Text(
                    i18n[langService
                        .currentLanguage]?['share_result_page']?['economic_value'] ??
                        'The economic value of your unpaid contributions',
                    style: AppTextStyles.normal(
                        context, color: AppColors.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.03),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      vertical: MediaQuery
                          .of(context)
                          .size
                          .height * 0.02,
                      horizontal: MediaQuery
                          .of(context)
                          .size
                          .width * 0.06,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.primary),
                    ),
                    child: Text(
                      '${langService.convertNumberToBengali(
                          totalScore.toString())} ${i18n[langService
                          .currentLanguage]?['share_result_page']?['points_suffix'] ??
                          'points'}',
                      style: AppTextStyles.h1(context),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.02),

                  Text(
                    i18n[langService
                        .currentLanguage]?['share_result_page']?['weekly_value'] ??
                        'Daily value of your unpaid work',
                    style: AppTextStyles.normal(
                        context, color: AppColors.textPrimary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Hours data message
          if (!hasHourData)
            Padding(
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.04),
              child: Text(
                i18n[langService
                    .currentLanguage]?['share_result_page']?['no_hour_data'] ??
                    'No hour data available',
                style: AppTextStyles.normal(
                    context, color: AppColors.textPrimary),
                textAlign: TextAlign.center,
              ),
            ),

          // Only show chart if we have data
          if (hasHourData)
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(
                  MediaQuery
                      .of(context)
                      .size
                      .width * 0.04,
                  0,
                  MediaQuery
                      .of(context)
                      .size
                      .width * 0.04,
                  MediaQuery
                      .of(context)
                      .size
                      .height * 0.02
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: HourChart(
                hoursByQuestion: hoursByQuestion ?? {},
                questionsById: questionsById,
                taskNames: taskNames,
              ),
            ),

          // Detailed breakdown card
          if (hasHourData)
            Container(
              width: double.infinity,
              margin: EdgeInsets.fromLTRB(
                  MediaQuery
                      .of(context)
                      .size
                      .width * 0.04,
                  0,
                  MediaQuery
                      .of(context)
                      .size
                      .width * 0.04,
                  MediaQuery
                      .of(context)
                      .size
                      .height * 0.03
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    spreadRadius: 2,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: EdgeInsets.all(MediaQuery
                    .of(context)
                    .size
                    .width * 0.05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      i18n[langService
                          .currentLanguage]?['share_result_page']?['detailed_breakdown'] ??
                          'Detailed Breakdown',
                      style: AppTextStyles.h2(context),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.02),

                    // Headers
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            i18n[langService
                                .currentLanguage]?['share_result_page']?['activity'] ??
                                'Activity',
                            style: AppTextStyles.normal(context,
                                color: AppColors.textPrimary),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${i18n[langService
                                .currentLanguage]?['share_result_page']?['hours_week'] ??
                                'Hours/Week'} ${i18n[langService
                                .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                                'hrs'}',
                            style: AppTextStyles.normal(context,
                                color: AppColors.textPrimary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            i18n[langService
                                .currentLanguage]?['share_result_page']?['value'] ??
                                'Value',
                            style: AppTextStyles.normal(context,
                                color: AppColors.textPrimary),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),

                    Divider(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04),

                    // List of activities
                    ...activeScores.map((entry) =>
                        _buildActivityRow(
                          context,
                          entry.key,
                          entry.value,
                          hoursByQuestion?[entry.key] ?? 0,
                          questionsById[entry.key],
                          taskNames, // pass taskNames here
                        )),

                    Divider(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.04),

                    // Total row
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Text(
                            i18n[langService
                                .currentLanguage]?['share_result_page']?['total_value'] ??
                                'Total Value',
                            style: AppTextStyles.h2(context),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${langService.convertNumberToBengali(
                                _calculateTotalHours(hoursByQuestion)
                                    .toStringAsFixed(1))} ${i18n[langService
                                .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                                'hrs'}',
                            style: AppTextStyles.normal(context,
                                color: AppColors.textPrimary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${langService.convertNumberToBengali(
                                totalScore.toString())} ${i18n[langService
                                .currentLanguage]?['share_result_page']?['points_suffix'] ??
                                'points'}',
                            style: AppTextStyles.h1(context),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, String id, int score,
      double hours, Question? question, Map<String, String> taskNames) {
    final langService = Provider.of<LanguageServiceMobile>(context);
    final String? mappedName = taskNames[id];
    final String activityName = (mappedName != null && mappedName.isNotEmpty)
        ? mappedName
        : id;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: MediaQuery
          .of(context)
          .size
          .height * 0.01),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              activityName,
              style: AppTextStyles.normal(
                  context, color: AppColors.textPrimary),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${langService.convertNumberToBengali(
                  hours.toStringAsFixed(1))} ${i18n[langService
                  .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                  'hrs'}',
              style: AppTextStyles.normal(
                  context, color: AppColors.textPrimary),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${langService.convertNumberToBengali(
                  score.toString())} ${i18n[langService
                  .currentLanguage]?['share_result_page']?['points_suffix'] ??
                  'points'}',
              style: AppTextStyles.normal(
                  context, color: AppColors.textPrimary),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  double _calculateTotalHours(Map<String, double>? hoursByQuestion) {
    if (hoursByQuestion == null) return 0;
    return hoursByQuestion.values.fold(0.0, (sum, hours) => sum + hours);
  }

  void _shareResults(BuildContext context, Map<String, dynamic> scores,
      int totalScore, Map<String, double>? hoursByQuestion,
      Map<String, Question> questionsById) {
    // This would normally use a sharing plugin
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(i18n['en']?['share_result_page']?['share_message'] ??
            'Sharing functionality would be implemented here'),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  void _copyToClipboard(BuildContext context, Map<String, dynamic> scores,
      int totalScore, Map<String, double>? hoursByQuestion,
      Map<String, Question> questionsById) {
    final langService = Provider.of<LanguageServiceMobile>(context);
    // Generate text summary
    String summary = "My Unpaid Work Value: ${langService
        .convertNumberToBengali(totalScore.toString())} ${i18n[langService
        .currentLanguage]?['share_result_page']?['points_suffix'] ??
        'points'} per week\n\n";
    summary += "Detailed Breakdown:\n";

    // List activities
    for (var entry in scores.entries.where((e) => e.value > 0)) {
      final String id = entry.key;
      final int score = entry.value;
      final double hours = hoursByQuestion?[id] ?? 0;
      final String activityKey = questionsById[id]?.questionKey ?? 'other';
      final String activityName = i18n['en']?['activity_names']?[activityKey] ??
          i18n['en']?['activity_names']?[activityKey] ??
          'Activity';

      summary +=
      "$activityName: ${langService.convertNumberToBengali(
          hours.toStringAsFixed(1))} ${i18n[langService
          .currentLanguage]?['share_result_page']?['hours_suffix'] ??
          'hrs'}/week = ${langService.convertNumberToBengali(
          score.toString())} ${i18n[langService
          .currentLanguage]?['share_result_page']?['points_suffix'] ??
          'points'}\n";
    }

    summary += "\nCalculated by the Unpaid Work Calculator";

    // Copy to clipboard
    Clipboard.setData(ClipboardData(text: summary));

    // Show confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Results copied to clipboard'),
        backgroundColor: AppColors.primary,
      ),
    );
  }
}
