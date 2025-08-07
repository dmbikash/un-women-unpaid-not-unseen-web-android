import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../controller/routes.dart';
import '../entities/questions.dart';
import '../providers/question_provider_old.dart';
import '../design/themes/colors.dart';
import '../design/text/textStyles.dart';
import '../models/question.dart';
import '../providers/question_provider_principal.dart';
import '../services/languages.dart';
import '../services/question_service.dart';
import '../widgets/hour_chart.dart';
import '../services/language_service.dart';

class ShareResultPage extends StatefulWidget {
   ShareResultPage({super.key});

  @override
  State<ShareResultPage> createState() => _ShareResultPageState();
}

class _ShareResultPageState extends State<ShareResultPage> {
  late QuestionProviderPrincipal questionProviderPrincipal ;


  @override
  void initState() {
    questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(context,listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langService = Provider.of<LanguageServiceMobile>(context);
    // Get the passed data from arguments

    final String backText = i18n[langService
        .currentLanguage]?['result_page']?['back'] ?? 'Back';


    // Check if we have any hours data

    return Scaffold(
      backgroundColor: AppColors.primary,
      appBar: AppBar(
        title: Text(
          i18n[langService
              .currentLanguage]?['share_result_page']?['title'] ??
              'Share Your Results',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          // Back button
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              // Reset the provider state and navigate to landing page instead of questions
              questionProviderPrincipal.reset();
              Navigator.pushReplacementNamed(context, WebRoutes.landing);
            },
          ),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.only(
          bottom: MediaQuery
              .of(context)
              .size
              .height * 0.03,
        ),
        physics: const ClampingScrollPhysics(),
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
                  .width * 0.04,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
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
                    style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.05,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
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
                    style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.035,
                      color: Colors.black87,
                    ),
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
                          questionProviderPrincipal.getGrandTotalPoint().toStringAsFixed(2))} '
                          '${i18n[langService
                          .currentLanguage]?['share_result_page']?['value'] ??
                          'Points'}',
                      style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.07,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
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
                        'Weekly value of your unpaid work',
                    style: TextStyle(
                      fontSize: MediaQuery
                          .of(context)
                          .size
                          .width * 0.035,
                      color: Colors.black54,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),

          // Hours data message
          if (questionProviderPrincipal.getGrandTotalPoint()==0)
            Padding(
              padding: EdgeInsets.all(MediaQuery
                  .of(context)
                  .size
                  .width * 0.04),
              child: Text(
                i18n[langService
                    .currentLanguage]?['share_result_page']?['no_hour_data'] ??
                    'No hour data available',
                style: TextStyle(
                  fontSize: MediaQuery
                      .of(context)
                      .size
                      .width * 0.04,
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),

          // Only show chart if we have data
          if (questionProviderPrincipal.getGrandTotalPoint()>0)
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
              child: HourChart(questions: questionProviderPrincipal.answerSheet,

              ),
            ),

          // Detailed breakdown card
          if (questionProviderPrincipal.getGrandTotalPoint()>0)
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
                      style: TextStyle(
                        fontSize: MediaQuery
                            .of(context)
                            .size
                            .width * 0.045,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                      ),
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
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${i18n[langService
                                .currentLanguage]?['share_result_page']?['hours_week'] ??
                                'Hours/Day'} '
                                // '${i18n[langService
                                // .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                                // 'hrs'}'
                            ,
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            i18n[langService
                                .currentLanguage]?['share_result_page']?['value'] ??
                                'Point',
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.035,
                              fontWeight: FontWeight.w600,
                            ),
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

                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: questionProviderPrincipal.answerSheet.length,
                        itemBuilder: (context, index){
                          List answerList = questionProviderPrincipal.answerSheet;
                          return _buildActivityRow(
                            context,
                            /// name
                            i18n[langService
                              .currentLanguage]?['activity_names']?[answerList[index]["question_key"]] ?? "N/A",
                            /// total  hours
                            "${langService.convertNumberToBengali(
                                answerList[index]["hour"].toString())} "
                                // "${i18n[langService
                                // .currentLanguage]?['result_page']?['points_suffix'] ??
                                // 'points'}"
                                "",
                            /// total points

                            "${langService.convertNumberToBengali(
                                answerList[index]["total_point"].toString())} "
                                // "${i18n[langService
                                // .currentLanguage]?['result_page']?['points_suffix'] ??
                                // 'points'}"
                            ,
                            answerList[index]["answer"],

                          );
                        }),

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
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${langService.convertNumberToBengali(
                               questionProviderPrincipal.getGrandTotalHour().toStringAsFixed(2)
                                    )} '
                                // '${i18n[langService
                                // .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                                // 'hrs'}'
                            ,
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.04,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Text(
                            '${langService.convertNumberToBengali(
                                questionProviderPrincipal.getGrandTotalPoint().toStringAsFixed(2)
                            )} '
                                // '${i18n[langService
                                // .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                                // 'hrs'}'
                            ,
                            style: TextStyle(
                              fontSize: MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.04,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: MediaQuery
                    .of(context)
                    .size
                    .width * 0.92, // Make button width match card width
                child: ElevatedButton(
                  onPressed: () {
                    // Reset the quiz and navigate to landing page instead of questions
                    questionProviderPrincipal.reset();
                    Navigator.pushReplacementNamed(
                        context, WebRoutes.landing);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery
                            .of(context)
                            .size
                            .height * 0.02),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                      side: BorderSide(color: Colors.black54),
                    ),
                  ),
                  child: Text(
                    backText,
                    style: ThemeTextStyles.button.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildActivityRow(BuildContext context, String activityName, String hours,
      String points,
      bool show,
      {bool isTotal = false}) {
    final langService = Provider.of<LanguageServiceMobile>(context);
    // Get the activity name from the activity_names section in the language file
    // Using the current language from language provider
    // Fallback to English names if translation not found


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
              style: ThemeTextStyles.body.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Text(
              '${langService.convertNumberToBengali(
                  hours)}  '
                  'x '
                  '${questionProviderPrincipal.selectedGender != null && questionProviderPrincipal.selectedGender=="Man" ? langService.convertNumberToBengali(
                  "60"): langService.convertNumberToBengali(
                  "50")}'
                  // '${i18n[langService
                  // .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                  // 'hrs'}'
              ,
              style: ThemeTextStyles.body,
              textAlign: TextAlign.right,
            ),
          ),

          Expanded(
            flex: 2,
            child: Text(
              '${langService.convertNumberToBengali(
                 points)} '
                  // '${i18n[langService
                  // .currentLanguage]?['share_result_page']?['points_suffix'] ??
                  // 'points'}'
              ,
              style: ThemeTextStyles.body.copyWith(
                color: AppColors.primary,
              ),
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
