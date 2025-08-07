import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:unwomen_unpaid_not_unseen/services/language_service.dart';
import '../design/themes/colors.dart';
import '../models/question.dart';
import '../services/languages.dart';
import '../services/language_service.dart';
import 'package:provider/provider.dart';

class HourChart extends StatelessWidget {
  final Map<String, double> hoursByQuestion;
  final Map<String, Question> questionsById;
  final Map<String, String>? taskNames;

  const HourChart({
    Key? key,
    required this.hoursByQuestion,
    required this.questionsById,
    this.taskNames,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final langService = Provider.of<LanguageServiceMobile>(context);

    // Filter to only show activities with hours > 0
    final Map<String, double> activeHours = Map.fromEntries(
        hoursByQuestion.entries.where((e) => e.value > 0)
    );

    // Prepare data for the chart
    List<PieChartSectionData> sections = [];
    int colorIndex = 0;
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

    // Activity names mapping
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

    // Legend items for the chart
    List<Widget> legendItems = [];

    // Set card/content width, chart max size responsive to web/mobile
    final double cardMaxWidth = screenWidth < 600 ? screenWidth : 600.0;
    final double compactChartMax = 180.0; // px
    final double chartWidth = cardMaxWidth * 0.22 < compactChartMax
        ? cardMaxWidth * 0.22
        : compactChartMax;
    final double chartHeight = chartWidth;
    final double pieRadius = chartWidth / 2;
    final double centerSpace = pieRadius * 0.67;

    // Create chart sections and legend items
    activeHours.forEach((id, hours) {
      final Color sectionColor = colors[colorIndex % colors.length];
      colorIndex++;

      final String? mappedName = taskNames?[id];
      final String activityName = (mappedName != null && mappedName.isNotEmpty)
          ? mappedName
          : id;

      // Add chart section
      sections.add(
        PieChartSectionData(
          value: hours,
          color: sectionColor,
          title: langService.convertNumberToBengali(hours.toStringAsFixed(1)),
          radius: pieRadius * 0.8,
          titleStyle: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: (chartWidth) * 0.12,
          ),
        ),
      );

      // Add legend item
      legendItems.add(
        Padding(
          padding: EdgeInsets.only(bottom: 8),
          child: Row(
            children: [
              Container(
                width: 16,
                height: 16,
                color: sectionColor,
              ),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  activityName,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              Text(
                '${langService.convertNumberToBengali(
                    hours.toStringAsFixed(1))} ${i18n[langService
                    .currentLanguage]?['share_result_page']?['hours_suffix'] ??
                    'hrs'}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      );
    });

    // If no data, show a placeholder
    if (sections.isEmpty) {
      return Center(
        child: Text(i18n[langService
            .currentLanguage]?['share_result_page']?['no_hour_data'] ??
            'No hour data available'),
      );
    }

    return Card(
      color: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              i18n[langService
                  .currentLanguage]?['share_result_page']?['weekly_hours_breakdown'] ??
                  'Weekly Hours Breakdown',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20),

            // Chart
            Center(
              child: SizedBox(
                width: chartWidth,
                height: chartHeight,
                child: PieChart(
                  PieChartData(
                    sections: sections,
                    centerSpaceRadius: centerSpace,
                    sectionsSpace: 2,
                    startDegreeOffset: 180,
                  ),
                ),
              ),
            ),

            SizedBox(height: 24),

            // Legend
            ...legendItems,
          ],
        ),
      ),
    );
  }
}
