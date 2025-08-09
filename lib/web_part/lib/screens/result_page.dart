// import 'package:flutter/material.dart';
// import 'package:unwomen_unpaid_not_unseen/services/language_service.dart';
// import 'package:unwomen_unpaid_not_unseen/web_wrapper.dart';
// import '../design/themes/colors.dart';
// import '../constants/text_styles.dart';
// import '../services/languages.dart';
// import '../controller/routes.dart';
// import 'package:provider/provider.dart';
// import '../providers/question_provider.dart';
// import '../widgets/page_scaffold.dart';
// import '../services/language_service.dart';
//
// class ResultPage extends StatelessWidget {
//   final String? name;
//   final double? totalHours;
//   final double? totalValue;
//   final Map<String, double>? selectedTasks;
//   final Map<String, int>? scores;
//   final int? totalScore;
//   final Map<String, double>? hoursByQuestion;
//   final Map<String, String>? taskNames;
//
//   const ResultPage({Key? key,
//     this.name,
//     this.totalHours,
//     this.totalValue,
//     this.selectedTasks,
//     this.scores,
//     this.totalScore,
//     this.hoursByQuestion,
//     this.taskNames}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // Safe language access
//     final langService = Provider.of<LanguageServiceMobile>(context);
//     final String title = i18n[langService
//         .currentLanguage]?['result_page']?['title'] ?? 'Results';
//     final String shareText = i18n[langService
//         .currentLanguage]?['result_page']?['share'] ?? 'Share';
//     final String backText = i18n[langService
//         .currentLanguage]?['result_page']?['back'] ?? 'Back';
//
//     // Scores/points from constructor params only
//     final Map<String, int> usedScores = scores ?? {};
//     final int usedTotalScore = totalScore ?? 0;
//     final Map<String, double>? usedHoursByQuestion = hoursByQuestion;
//
//     // Map to convert question keys to translation keys
//     final Map<String, String?> activityKeys = {
//       '0': 'cooking',
//       '1': 'cleaning',
//       '2': 'childcare',
//       '3': 'eldercare',
//       '4': 'grocery',
//       '5': 'laundry',
//       '6': 'gardening',
//       '7': 'homework_help',
//       '8': 'emotional_support',
//       '9': 'water_collection',
//       '10': 'health_care_support',
//       '11': 'other',
//     };
//
//     // Calculate remaining value
//     int remainingValue = usedTotalScore -
//         usedScores.entries.where((e) => e.value > 0).toList().fold(
//             0, (sum, e) => sum + e.value);
//
//     // Calculate top activities
//     List<MapEntry<String, int>> topActivities = [];
//     if (usedScores.isNotEmpty) {
//       topActivities = usedScores.entries.where((e) => e.value > 0).toList()
//         ..sort((a, b) => b.value.compareTo(a.value));
//
//       // Show all activities, not just top 3
//     }
//
//     return PageScaffold(
//       title: title,
//       ensureScrollable: true,
//       // Ensure scrolling is enabled
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: MediaQuery
//                 .of(context)
//                 .size
//                 .width * 0.04, // 4% padding on each side for 92% content width
//             vertical: MediaQuery
//                 .of(context)
//                 .size
//                 .height * 0.01,
//           ),
//           child: WebWrapper(
//            // crossAxisAlignment: CrossAxisAlignment.start,
//             //mainAxisSize: MainAxisSize.min,
//             children: [
//               Card(
//                 color: Colors.white,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding:
//                   EdgeInsets.symmetric(horizontal :MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.06,
//                   vertical: 75
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         i18n[langService
//                             .currentLanguage]?['result_page']?['your_unpaid_work_value'] ??
//                             "Your Unpaid Work Value",
//                         style: AppTextStyles.h1(context),
//                         textAlign: TextAlign.center,
//                       ),
//                       if (name != null && name!.isNotEmpty)
//                         Padding(
//                           padding: EdgeInsets.only(top: 4, bottom: 8),
//                           child: Text(
//                             'Name: $name',
//                             style: AppTextStyles.h2(context),
//                             textAlign: TextAlign.center,
//                           ),
//                         ),
//                       SizedBox(height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.02),
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: MediaQuery
//                               .of(context)
//                               .size
//                               .width * 0.04,
//                           vertical: MediaQuery
//                               .of(context)
//                               .size
//                               .height * 0.02,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue.shade50,
//                           borderRadius: BorderRadius.circular(16),
//                           border: Border.all(color: Colors.lightBlue.shade100),
//                         ),
//                         child: Text(
//                           "${langService.convertNumberToBengali(
//                               usedTotalScore.toString())} ${i18n[langService
//                               .currentLanguage]?['result_page']?['points_suffix'] ??
//                               'points'}",
//                           style: AppTextStyles.largeNumber(context,
//                               color: AppColors.primary),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.02),
//                       Text(
//                         i18n[langService
//                             .currentLanguage]?['result_page']?['weekly_value'] ??
//                             "Weekly value of your unpaid work contribution",
//                         style: AppTextStyles.lightText(context),
//                         textAlign: TextAlign.center,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery
//                   .of(context)
//                   .size
//                   .height * 0.01),
//               Card(
//                 color: Colors.white,
//                 elevation: 2,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(16.0),
//                 ),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(
//                      horizontal:  MediaQuery
//                       .of(context)
//                       .size
//                       .width * 0.06,
//                     vertical: 75
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Text(
//                         i18n[langService
//                             .currentLanguage]?['result_page']?['breakdown'] ??
//                             "Breakdown",
//                         style: AppTextStyles.h2(
//                             context, color: AppColors.primary),
//                       ),
//                       SizedBox(height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.01),
//                       ...(
//                           topActivities.isNotEmpty
//                               ? topActivities.map((activity) {
//                             final String? mappedName = taskNames?[activity.key];
//                             final String displayName = (mappedName != null &&
//                                 mappedName.isNotEmpty) ? mappedName : activity
//                                 .key;
//                             return _buildBreakdownItem(
//                                 context,
//                                 displayName,
//                                 "${langService.convertNumberToBengali(
//                                     activity.value
//                                         .toString())} ${i18n[langService
//                                     .currentLanguage]?['result_page']?['points_suffix'] ??
//                                     'points'}"
//                             );
//                           }).toList()
//                               : []
//                       ),
//                       Divider(height: MediaQuery
//                           .of(context)
//                           .size
//                           .height * 0.03),
//                       _buildBreakdownItem(
//                         context,
//                         i18n[langService
//                             .currentLanguage]?['result_page']?['total_value'] ??
//                             "Total value",
//                         "${langService.convertNumberToBengali(
//                             usedTotalScore.toString())} ${i18n[langService
//                             .currentLanguage]?['result_page']?['points_suffix'] ??
//                             'points'}",
//                         isTotal: true,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: MediaQuery
//                   .of(context)
//                   .size
//                   .height * 0.01),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: ElevatedButton(
//                       onPressed: () {
//                         Navigator.pushNamed(
//                           context,
//                           '/share_result',
//                           arguments: {
//                             'scores': usedScores,
//                             'totalScore': usedTotalScore,
//                             'hoursByQuestion': usedHoursByQuestion,
//                             'taskNames': taskNames,
//                           },
//                         );
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.white,
//                         foregroundColor: AppColors.primary,
//                         padding: EdgeInsets.symmetric(
//                             vertical: MediaQuery
//                                 .of(context)
//                                 .size
//                                 .height * 0.02),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(16),
//                         ),
//                       ),
//                       child: Text(
//                         i18n[langService
//                             .currentLanguage]?['result_page']?['view_breakdown'] ??
//                             "View Breakdown",
//                         style: AppTextStyles.h1(context)
//                             .copyWith(
//                           color: AppColors.primary,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: MediaQuery
//                   .of(context)
//                   .size
//                   .height * 0.01),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: MediaQuery
//                         .of(context)
//                         .size
//                         .width * 0.92, // Make button width match card width
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildBreakdownItem(BuildContext context, String label, String value,
//       {bool isTotal = false}) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//           vertical: MediaQuery
//               .of(context)
//               .size
//               .height * 0.008),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: isTotal
//                 ? AppTextStyles.h2(context, color: AppColors.primary)
//                 : AppTextStyles.normal(context, color: AppColors.textPrimary),
//           ),
//           Text(
//             value,
//             style: isTotal
//                 ? AppTextStyles.h2(context, color: AppColors.primary)
//                 : AppTextStyles.normal(context, color: AppColors.textPrimary),
//           ),
//         ],
//       ),
//     );
//   }
// }
