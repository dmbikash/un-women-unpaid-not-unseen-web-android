import 'package:flutter/material.dart';
import '../models/question.dart';
import '../design/themes/colors.dart';
import 'package:provider/provider.dart';
import '../providers/question_provider_old.dart';
import '../services/languages.dart';
import '../services/language_service.dart';

class HourOptionSelector extends StatefulWidget {
//  final List<HourOption> options;
  final Function(double) onHourSelected;
  final bool visible;

  const HourOptionSelector({
    super.key,
   // required this.options,
    required this.onHourSelected,
    this.visible = false,
  });

  @override
  State<HourOptionSelector> createState() => _HourOptionSelectorState();
}

class _HourOptionSelectorState extends State<HourOptionSelector> {
  double _selectedHours = 3.0;

  @override
  void initState() {
    super.initState();
    _selectedHours = 3.0; // Always start with 1
  }

  @override
  void didUpdateWidget(HourOptionSelector oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Don't auto-update from provider - we want to use our local state until user confirms

    // Reset selected hours when the selector is shown for a new question
    if (widget.visible && !oldWidget.visible) {
      setState(() {
        _selectedHours = 1.0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionProvider_old_app>(context);
    final langService = Provider.of<LanguageServiceMobile>(context);

    // Get responsive dimensions
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;

    // Only show selector if it's visible
    if (!widget.visible) {
      return SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        Text(
          i18n[langService
              .currentLanguage]?['hour_option_selector']?['hours_per_week'] ??
              'How many hours per week?',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),

        SizedBox(height: 10,),

        // Display selected hours in a box with confirm button
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Hours display box
            Container(
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.015,
                horizontal: 10,
              ),
              decoration: BoxDecoration(
                //color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.primary),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/Image/clock.png',
                    width: screenWidth * 0.06,
                    height: screenWidth * 0.06,

                  ),
                  SizedBox(width: screenWidth * 0.02),
                  Text(
                    '${langService.convertNumberToBengali(_selectedHours
                        .toStringAsFixed(1))} ',
                    style: TextStyle(
                      fontSize:26,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),Text(
                    '${i18n[langService
                        .currentLanguage]?['hour_option_selector']?['hours_suffix'] ??
                        'hours'}',
                    style: TextStyle(
                      fontSize:16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            // Confirm button (tick mark)
            SizedBox(width: MediaQuery
                .of(context)
                .size
                .width * 0.025),
            InkWell(
              onTap: () {
                // Get the current question from the provider
                final questionProvider = Provider.of<QuestionProvider_old_app>(
                    context, listen: false);
                final isLastQuestion = questionProvider.currentIndex ==
                    questionProvider.totalQuestions - 1;

                // If selected 0 hours, treat it as a "No"
                if (_selectedHours < 1.0) {
                  // Less than 1 hour, equivalent to "No" answer
                  Navigator.of(context).pop();
                  return;
                }

                // Select hour and trigger callback
                widget.onHourSelected(_selectedHours);
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.primary),
                ),
                child: Icon(
                  Icons.check,
                  color: AppColors.primary,
                  size: 34,
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 20,),

        // Custom styled hour slider
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Minus button outside
            _buildAdjustmentButton(
              icon: Icons.remove,
              onPressed: () {
                if (_selectedHours > 1) {
                  setState(() {
                    _selectedHours =
                        (_selectedHours - 0.5).clamp(1.0, 24);
                  });
                }
              },
            ),

            // Space between button and slider
            SizedBox(width: screenWidth * 0.015),

            // Container with border for slider
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 10
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(screenWidth *
                      0.04),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The slider
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 10,

                        // Increased track height
                        activeTrackColor: AppColors.primary,
                        inactiveTrackColor: Colors.grey.withOpacity(
                            0.2),
                        thumbColor: Colors.white,
                        overlayColor: AppColors.primary.withOpacity(
                            0.2),
                        thumbShape: RoundSliderThumbShape(
                          enabledThumbRadius: 14, // Larger thumb
                          elevation: 4,
                        ),
                        overlayShape: RoundSliderOverlayShape(
                            overlayRadius: screenWidth * 0.05),
                        valueIndicatorColor: AppColors.primary,
                        valueIndicatorTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      child: Slider(
                        padding: EdgeInsets.zero,
                        value: _selectedHours,
                        min: 1,
                        max: 24,
                        divisions: 48,
                        // 90 * 2 for 0.5 step precision
                        label: langService.convertNumberToBengali(
                            _selectedHours.toStringAsFixed(1)),
                        onChanged: (value) {
                          // Round to nearest 0.5
                          double roundedValue = (value * 2).round() / 2;
                          setState(() {
                            _selectedHours = roundedValue;
                          });
                        },
                      ),
                    ),

                    // Hour labels with more detailed markers inside the slider container
                    SizedBox(width: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${langService.convertNumberToBengali("1")}h',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${langService.convertNumberToBengali(
                              "8")}h',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${langService.convertNumberToBengali(
                              "16")}h',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${langService.convertNumberToBengali(
                              "24")}h',
                          style: TextStyle(
                            fontSize: screenWidth * 0.028,
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),

            // Space between slider and button
            SizedBox(width: screenWidth * 0.015),

            // Plus button outside
            _buildAdjustmentButton(
              icon: Icons.add,
              onPressed: () {
                if (_selectedHours < 24) {
                  setState(() {
                    _selectedHours =
                        (_selectedHours + 0.5).clamp(1.0, 24);
                  });
                }
              },
            ),
          ],
        ),
      ],
    );
  }

  // Helper method to build hour labels
  Widget _buildHourLabel(String text) {
    return Column(
      children: [
        Container(
          height: 4,
          width: 2,
          color: Colors.grey.withOpacity(0.5),
        ),
        SizedBox(height: 4),
        Text(
          text,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // Helper method to build plus/minus buttons
  Widget _buildAdjustmentButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    final buttonSize = 55.0; // 9% of screen width

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: buttonSize,
        height: buttonSize,
        padding: EdgeInsets.all(screenWidth * 0.02),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(screenWidth * 0.02),
          border: Border.all(
            color: AppColors.primary,
            width: 1,
          ),
        ),
        child: FittedBox(
          fit: BoxFit.contain,
          child: Icon(
            icon,
            color: AppColors.primary,
          ),
        ),
      ),
    );
  }
}
