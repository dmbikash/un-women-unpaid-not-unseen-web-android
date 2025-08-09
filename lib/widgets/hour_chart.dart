import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../design/themes/colors.dart';
import '../services/languages.dart';
import '../services/language_service.dart';
import 'package:provider/provider.dart';

class HourChart extends StatelessWidget {
  final List<Map<dynamic, dynamic>> questions;

  const HourChart({
    super.key,
    required this.questions,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final langService = Provider.of<LanguageServiceMobile>(context);

    // Filter only entries with hour > 0
    final List<Map<dynamic, dynamic>> activeQuestions =
    questions.where((q) => (q['hour'] ?? 0) > 0).toList();

    final List<Color> colors = [
      Colors.blue.shade400,
      Colors.green.shade400,
      Colors.red.shade400,
      Colors.orange.shade400,
      Colors.purple.shade400,
      Colors.teal.shade400,
      Colors.amber.shade400,
      Colors.indigo.shade400,
    ];

    final Map<String, String> activityNames = {
      'cooking': 'Cooking',
      'cleaning': 'Cleaning',
      'childcare': 'Childcare',
      'eldercare': 'Elder Care',
      'grocery': 'Grocery Shopping',
      'laundry': 'Laundry',
      'gardening': 'Gardening',
      'homework_help': 'Homework Help',
      'emotional_support': 'Emotional Support',
      'pets': 'Pet Care',
      'water_collection': 'Water Collection',
      'health_care_support': 'Healthcare Support',
      'other': 'Other Activities',
    };

    List<PieChartSectionData> sections = [];
    List<Widget> legendItems = [];

    int colorIndex = 0;

    for (var q in activeQuestions) {
      final String questionKey = q['question_key'] ?? 'other';
      final double hours = (q['hour'] as num).toDouble();
      final Color sectionColor = colors[colorIndex % colors.length];
      colorIndex++;

      final String activityName = i18n[langService.currentLanguage]?['activity_names']?[questionKey] ??
          activityNames[questionKey] ??
          'Activity';

      // Add chart section
      sections.add(
        PieChartSectionData(
          value: hours,
          color: sectionColor,
          title: langService.convertNumberToBengali(hours.toStringAsFixed(1)),
          radius:  MediaQuery.of(context).size.width >600 ?screenWidth * 0.03 :screenWidth * 0.15,
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      );

      // Add legend item
      legendItems.add(
        Padding(
          padding: EdgeInsets.only(bottom: screenHeight * 0.01),
          child: Row(
            children: [
              Container(
                width: screenWidth * 0.04,
                height: screenWidth * 0.04,
                color: sectionColor,
              ),
              SizedBox(width: screenWidth * 0.02),
              Expanded(
                child: Text(
                  activityName,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text(
                '${langService.convertNumberToBengali(hours.toStringAsFixed(1))} ${i18n[langService.currentLanguage]?['share_result_page']?['hours_suffix'] ?? 'hrs'}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    }

    // if (sections.isEmpty) {
    //   return Center(
    //     child: Text(i18n[langService.currentLanguage]?['share_result_page']?['no_hour_data'] ??
    //         'No hour data available'),
    //   );
    // }

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              i18n[langService.currentLanguage]?['share_result_page']?['weekly_hours_breakdown'] ??
                  'Weekly Hours Breakdown',
              style: TextStyle(
                fontSize:18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: screenHeight * 0.03),

            // Chart
            SizedBox(
              height: screenWidth>600 ?500 : screenHeight * 0.25,
              child: PieChart(
                PieChartData(

                  sections: sections,
                  centerSpaceRadius: screenWidth * 0.1,
                  sectionsSpace: 2,
                  startDegreeOffset: 180,
                  pieTouchData: PieTouchData(enabled: false),
                ),
                duration: const Duration(milliseconds: 0),
              ),
            ),

            SizedBox(height: screenHeight * 0.03),

            // Legend
            ...legendItems,
          ],
        ),
      ),
    );
  }
}
