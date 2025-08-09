import 'package:flutter/material.dart';
import 'package:unwomen_unpaid_not_unseen/web_wrapper.dart';
import '../design/themes/colors.dart';
import '../design/text/textStyles.dart';
import '../providers/question_provider_principal.dart';
import '../services/languages.dart';
import '../controller/routes.dart';
import 'package:provider/provider.dart';
import '../providers/question_provider_old.dart';
import '../widgets/page_scaffold.dart';
import '../services/language_service.dart';

class ResultPage extends StatefulWidget {
  bool isWebRoute;

   ResultPage({
     this.isWebRoute = false,
     super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
   late QuestionProviderPrincipal questionProviderPrincipal;

   @override
  void initState() {
     questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(context,listen: false);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Safe language access
    final langService = Provider.of<LanguageServiceMobile>(context);
    final String title = i18n[langService
        .currentLanguage]?['result_page']?['title'] ??
        'Results';
    final String shareText = i18n[langService
        .currentLanguage]?['result_page']?['share'] ??
        'Share';
    final String backText = i18n[langService
        .currentLanguage]?['result_page']?['back'] ?? 'Back';

    // Get the answers from route arguments






      // TODO: implement initState





    return PageScaffold(
      topBranding: false,
      title: title,
      ensureScrollable: true, // Ensure scrolling is enabled
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery
                .of(context)
                .size
                .width * 0.04, // 4% padding on each side for 92% content width
            vertical: MediaQuery
                .of(context)
                .size
                .height * 0.01,
          ),
          child: WebWrapper(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery
                            .of(context)
                            .size
                            .width * 0.06,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              i18n[langService
                                  .currentLanguage]?['result_page']?['your_unpaid_work_value'] ??
                                  "Your Unpaid Work Value",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.02,),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                horizontal: MediaQuery
                                    .of(context)
                                    .size
                                    .width * 0.04,
                                vertical: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.02,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.lightBlue.shade50,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: Colors.lightBlue.shade100),
                              ),
                              child: Text(
                                "${langService.convertNumberToBengali(
                                    questionProviderPrincipal.getGrandTotalPoint().toStringAsFixed(2))} ${i18n[langService
                                    .currentLanguage]?['result_page']?['value'] ??
                                    'Points'}",
                                style: TextStyle(
                                  fontSize: 28,
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
                                  .currentLanguage]?['result_page']?['weekly_value'] ??
                                  "Weekly value of your unpaid work contribution",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w400,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01),
                    Card(
                      color: Colors.white,
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(MediaQuery
                            .of(context)
                            .size
                            .width * 0.06),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              i18n[langService
                                  .currentLanguage]?['result_page']?['breakdown'] ??
                                  "Breakdown",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            ),
                            SizedBox(height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.01),

                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: questionProviderPrincipal.answerSheet.length,
                                    itemBuilder: (context, index){
                                    List answerList = questionProviderPrincipal.answerSheet;
                                  return _buildBreakdownItem( context,   i18n[langService
                                      .currentLanguage]?['activity_names']?[answerList[index]["question_key"]] ?? "N/A",
                                    "${langService.convertNumberToBengali(
                                        answerList[index]["total_point"].toStringAsFixed(2))} ${i18n[langService
                                        .currentLanguage]?['result_page']?['points_suffix'] ??
                                        'points'}",
                                    answerList[index]["answer"],

                                  );
                                }),

                                // _buildBreakdownItem(
                                //     context,
                                //     "As",
                                //     "ss",
                                //
                                //     // i18n[langService
                                //     //     .currentLanguage]?['activity_names']?[activityKeys[activity
                                //     //     .key] ?? 'other'] ??
                                //     //     i18n['en']?['activity_names']?[activityKeys[activity
                                //     //         .key] ?? 'other'] ??
                                //     //     "Activity ",
                                //     //
                                //     // "${langService.convertNumberToBengali(
                                //     //     "404")} ${i18n[langService
                                //     //     .currentLanguage]?['result_page']?['points_suffix'] ??
                                //     //     'points'}",
                                // ),

                            // No need for "Other tasks" since we're showing all activities now
                            Divider(height: MediaQuery
                                .of(context)
                                .size
                                .height * 0.03),
                            _buildBreakdownItem(
                                context,
                                i18n[langService
                                    .currentLanguage]?['result_page']?['total_value'] ??
                                    "Total value",
                                "${langService.convertNumberToBengali(
                                   questionProviderPrincipal.getGrandTotalPoint().toStringAsFixed(2))} "
                                    // "${i18n[langService
                                    // .currentLanguage]?['result_page']?['points_suffix'] ??
                                    // 'points'}"
                                ,
                                 true,

                                isTotal: true),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.92, // Make button width match card width
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            WebRoutes.webShareResult,

                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppColors.primary,
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          i18n[langService
                              .currentLanguage]?['result_page']?['view_breakdown'] ??
                              "View Breakdown",
                          style: ThemeTextStyles.button.copyWith(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.01),
                    SizedBox(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.92, // Make button width match card width
                      child: ElevatedButton(
                        onPressed: () {
                          // Reset the quiz and navigate to landing page instead of questions
                          questionProviderPrincipal.reset();
                          widget.isWebRoute?
                          Navigator.pushReplacementNamed(
                              context, WebRoutes.webHome)
                              :
                          Navigator.pushReplacementNamed(
                              context, AppRoutes.landing);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary.withOpacity(0.2),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                              vertical: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.02),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                        child: Text(
                          backText,
                          style: ThemeTextStyles.button.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBreakdownItem(BuildContext context, String label, String value,
      bool show,
      {bool isTotal = false}) {
    return show? Padding(
      padding: EdgeInsets.symmetric(
          vertical: MediaQuery
              .of(context)
              .size
              .height * 0.008),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal ? ThemeTextStyles.heading : ThemeTextStyles.body,
          ),
          Text(
            value,
            style: isTotal ? ThemeTextStyles.heading : ThemeTextStyles.body,
          ),
        ],
      ),
    ):SizedBox();
  }
}
