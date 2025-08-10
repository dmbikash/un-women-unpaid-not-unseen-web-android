import '../../../entities/questions.dart';
import '../../../providers/question_provider_principal.dart';
import '../../../widgets/dropdowns.dart';
import '../constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../constants/app_colors.dart';
import 'customModal.dart';

class TaskCard extends StatefulWidget {
  final String title;
  final String question;
  final String questionKey;
  final String imagePath;
   double defaultHours;
   bool isSelected;
  final int currentIndex;

   TaskCard({
    super.key,
    required this.title,
    required this.question,
    required this.questionKey,
    required this.imagePath,
    required this.defaultHours,
    required this.isSelected,
    required this.currentIndex,
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

  }
  late QuestionProviderPrincipal questionProviderPrincipal ;

  @override
  void initState() {
    // TODO: implement initState
    questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(context,listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

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
    //double hours =widget.defaultHours;

    return Consumer<QuestionProviderPrincipal>(
      builder: (context,questionProviderPrincipal, child ) {
        return InkWell(
          borderRadius: BorderRadius.circular(4),
          /// on card/box tap
          onTap: () {
            if(questionProviderPrincipal.userName==""|| questionProviderPrincipal.selectedGender==null){
              customPopUpModal("Please Enter Your Name and Select Your Sex",202,context, children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: TextField(
                    controller: questionProviderPrincipal.userName,
                    decoration: InputDecoration(
                      hintText: 'Enter your name',
                      filled: true,
                      fillColor: Colors.white,
                      label: Text("Name"),
                      labelStyle: TextStyle(color: Colors.black,
                          fontWeight: FontWeight.w500,
                          backgroundColor: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.blue.withOpacity(0.4)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.black54, width: 1.5),
                      ),
                    ),
                  ),
                ),
                buildDropdown(
                  "Sex", null, ["Woman", "Man"], (gender,) {
                  questionProviderPrincipal.selectedGender = gender;
                  questionProviderPrincipal.refresh();
                  },
                ),
              ]);
            }else{
              /// usaer info are avilable
              if(widget.isSelected == false){
                widget.isSelected = true;
                int index = widget.currentIndex;
                String question = widget.question;
                String questionKey = widget.questionKey;
                bool answer = widget.isSelected;
                double hour = widget.defaultHours;



                int point = questionProviderPrincipal.selectedGender != null && questionProviderPrincipal.selectedGender=="Man" ? questionList[widget.currentIndex]["points_men"]:  questionList[index]["points_women"];

                double totalPoint =point*hour ;
                questionProviderPrincipal.addAnswer(questionKey: questionKey, question: question, answer: answer, gender: questionProviderPrincipal.selectedGender?? "Man",
                  point: point,
                  hour: hour,
                  totalPoint: totalPoint,
                );

                questionProviderPrincipal.refresh();

              }
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
                          '${questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey).toStringAsFixed(1)} hours',
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
                          questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey), sliderHeight, buttonIconSize),
                    ),
                  ),
                if (widget.isSelected && questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey) > 0)
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        customBorder: const CircleBorder(),
                        /// on cross/clear/deselect card
                        onTap: () {
                          // questionProviderPrincipal.updateAnswer(key: "hour",  value: 0.0, questionKey: widget.questionKey);
                          widget.isSelected =false;
                          questionProviderPrincipal.removeAnswerFromSheet(questionKey: widget.questionKey);

                          // setState(() {
                          //   widget.defaultHouer = null;
                          // });
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
    );
  }

  Widget _buildHoursControls( double currentValue,
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
                    final newVal = (currentValue - 0.5).clamp(1, 24).toDouble();
                    questionProviderPrincipal.updateAnswer(key: "hour", value: newVal, questionKey: widget.questionKey);
                    print("currentValue");
                    print(currentValue);
                  }
                  print("currentValue");
                  print(currentValue);
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
                      value: questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey),
                      min: 1,
                      max: 24,
                      divisions: 48,
                      // For 0.5 increments
                      onChanged: (value) {
                        questionProviderPrincipal.updateAnswer(key: "hour", value: value, questionKey: widget.questionKey);

                        //  setState(() => _localHours = value);
                      },
                      onChangeEnd: (value) {
                       widget.defaultHours = value.toDouble();
                       questionProviderPrincipal.updateAnswer(key: "hour", value:  value.toDouble(), questionKey: widget.questionKey);
                      },
                    ),
                  ),
                ),
              ),
              // Plus button
              InkWell(
                onTap: () {
                  if (currentValue < 24) {
                    final newVal = (currentValue + 0.5).clamp(1, 24).toDouble();
                    questionProviderPrincipal.updateAnswer(key: "hour", value: newVal, questionKey: widget.questionKey);

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