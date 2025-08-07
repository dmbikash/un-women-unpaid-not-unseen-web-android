import '../constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../constants/app_colors.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String imagePath;
  final double defaultHours;
  final bool isSelected;

  const TaskCard({
    super.key,
    required this.title,
    required this.imagePath,
    required this.defaultHours,
    required this.isSelected,
  });

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  double? _localHours;

  @override
  void didUpdateWidget(covariant TaskCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If selection has changed or card is rebuilt, sync the local state
    if (!widget.isSelected) {
      _localHours = null;
    } else if (_localHours == null) {
      final provider = Provider.of<CalculatorProvider>(context, listen: false);
      _localHours = provider.selectedTasks[widget.title] ?? 0.0;
      print("local housrs $_localHours");
     // print(_localHours);
    }
  }

  @override
  Widget build(BuildContext context) {
    final calculatorProvider = Provider.of<CalculatorProvider>(context);
    final mq = MediaQuery.of(context);
    final width = mq.size.width;
    // Step-wise scale: special 700 fix for iconSize (and layout)
    double iconSize;
    bool is700 = width <= 700;
    if (is700)
      iconSize = 16;
    else if (width > 2000)
      iconSize = 40;
    else if (width > 1000)
      iconSize = 40;
    else if (width >= 700) iconSize = 20;
    else
      iconSize = 20;
    double sliderHeight = iconSize;
    double buttonIconSize = iconSize * 0.5;
    double columnSpacing = 3;
    double verticalPadding = 1;
    double horizontalPadding = 1;
    double hours = 0.0;
    if (widget.isSelected) {
      hours =
          _localHours ?? calculatorProvider.selectedTasks[widget.title] ?? 0.0;

      print("local housrs $_localHours");
      print(" housrs $hours");
      print(widget.isSelected);
    }
    return InkWell(
      borderRadius: BorderRadius.circular(4),
      /// on card/box tap
      onTap: () {
        if (!widget.isSelected) {
          calculatorProvider.selectTask(widget.title, widget.defaultHours);
          setState(() {
            _localHours = widget.defaultHours;
          });
        } else {
          print("else ${widget.defaultHours}");
          // double current = calculatorProvider.selectedTasks[widget.title] ??
          //     0.0;
          // if (current < 24.0) {
          //   double newVal = (current + widget.defaultHours).clamp(0, 24);
          //   calculatorProvider.updateTaskHours(widget.title, newVal);
          //   setState(() {
          //     _localHours = newVal;
          //   });
          // }
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.lightGray.withOpacity(0.4),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: widget.isSelected ? AppColors.primary : Colors.grey.shade300,
            width: widget.isSelected ? 2 : 1,
          ),
        ),
        child: Stack(
          children: [
            // Always keep main block centered
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: horizontalPadding, vertical: verticalPadding),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      widget.imagePath,
                      height: iconSize,
                      width: iconSize,
                    ),
                    SizedBox(height: columnSpacing),
                    Text(
                      widget.title,
                      style: AppTextStyles.fromStyle(
                          context, AppTextStyles.normal(context),
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      '${hours.toStringAsFixed(1)} hours',
                      style: AppTextStyles.small(context).copyWith(
                          color: AppColors.textSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            if (widget.isSelected)
              Positioned(
                left: 0,
                right: 0,
                bottom: is700 ? 12 : 8,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: is700 ? 16 : 8),
                  child: _buildHoursControls(
                      calculatorProvider, hours, sliderHeight, buttonIconSize),
                ),
              ),
            if (widget.isSelected && (hours ?? 0) > 0)
              Positioned(
                top: 6,
                right: 6,
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    /// on cross/clear/deselect card
                    onTap: () {
                      calculatorProvider.updateTaskHours(widget.title, 0);
                      setState(() {
                        _localHours = null;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red, width: 1),
                      ),
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.clear, size: MediaQuery.of(context).size.width > 1000? 16:8, color: Colors.red),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildHoursControls(CalculatorProvider provider, double currentValue,
      double sliderHeight, double buttonIconSize) {
    return Builder(
      builder: (context) =>
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Minus button
              InkWell(
                onTap: () {
                  if (currentValue > 0) {
                    final newVal = (currentValue - 0.5).clamp(0, 24).toDouble();
                    setState(() => _localHours = newVal);
                    provider.updateTaskHours(widget.title, newVal);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(sliderHeight / 9),
                  decoration: BoxDecoration(
                    color: currentValue <= 0 ? Colors.grey.shade200 : AppColors
                        .primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.remove,
                    size: buttonIconSize,
                    color: currentValue <= 0 ? Colors.grey.shade400 : AppColors
                        .primary,
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: sliderHeight,
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: sliderHeight / 7,
                      thumbShape: RoundSliderThumbShape(
                        enabledThumbRadius: 8,
                      ),
                      overlayShape: RoundSliderOverlayShape(
                          overlayRadius: sliderHeight / 1.4),
                      tickMarkShape: SliderTickMarkShape.noTickMark,
                      activeTrackColor: Color(0xFF007bb7),
                      inactiveTrackColor: AppColors.lightGray,
                      thumbColor: Color(0xFF007bb7),
                      overlayColor: Colors.transparent,
                    ),
                    child: Slider(
                      value: currentValue,
                      min: 0,
                      max: 24,
                      divisions: 48,
                      // For 0.5 increments
                      onChanged: (value) {
                        setState(() => _localHours = value);
                      },
                      onChangeEnd: (value) {
                        provider.updateTaskHours(
                            widget.title, value.toDouble());
                      },
                    ),
                  ),
                ),
              ),
              // Plus button
              InkWell(
                onTap: () {
                  if (currentValue < 24) {
                    final newVal = (currentValue + 0.5).clamp(0, 24).toDouble();
                    setState(() => _localHours = newVal);
                    provider.updateTaskHours(widget.title, newVal);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(sliderHeight / 9),
                  decoration: BoxDecoration(
                    color: currentValue >= 24 ? Colors.grey.shade200 : AppColors
                        .primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Icon(
                    Icons.add,
                    size: buttonIconSize,
                    color: currentValue >= 24 ? Colors.grey.shade400 : AppColors
                        .primary,
                  ),
                ),
              ),
            ],
          ),
    );
  }
}