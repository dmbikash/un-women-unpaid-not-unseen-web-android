import 'package:unwomen_unpaid_not_unseen/web_part/lib/widgets/cupertino_time_picker.dart';

import '../../../entities/questions.dart';
import '../../../providers/question_provider_principal.dart';
import '../../../widgets/dropdowns.dart';
import '../constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/calculator_provider.dart';
import '../constants/app_colors.dart';
import 'customModal.dart';

class TaskPopUpCard extends StatefulWidget {
  final String title;
  final String question;
  final String questionKey;
  final String imagePath;
  double defaultHours;
  bool isSelected;
  bool showSlider;
  final int currentIndex;

  TaskPopUpCard({
    super.key,
    required this.title,
    required this.question,
    required this.questionKey,
    required this.imagePath,
    required this.defaultHours,
    required this.isSelected,
    required this.showSlider,
    required this.currentIndex,
  });

  @override
  State<TaskPopUpCard> createState() => _TaskPopUpCardState();
}

class _TaskPopUpCardState extends State<TaskPopUpCard> {

  double? _localHours;
  double? _localMins =30;

  @override
  void didUpdateWidget(covariant TaskPopUpCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // If selection has changed or card is rebuilt, sync the local state
  }

  late QuestionProviderPrincipal questionProviderPrincipal;

  @override
  void initState() {
    // TODO: implement initState
    questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuestionProviderPrincipal>(
      builder: (context, questionProviderPrincipal, child) {
        return Container(
          margin: EdgeInsets.only(top: 20,bottom: 10),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color:  Colors.grey.shade300, width:  2 ),
          ),
          child: Column(
            children: [
              // Always keep main block centered
              SizedBox(height: 10),
              /// image and question
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(widget.imagePath, height: 50, width: 50),
                  SizedBox(width: 20,),
                  /// title and question
                  Text(
                    widget.title,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                    maxLines: 2,
                   // overflow: TextOverflow.ellipsis,
                  ),
                  // SizedBox(height: 5),
                  // Text(
                  //   '${questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey).toStringAsFixed(1)} hours',
                  //   style: TextStyle(fontSize: 12),
                  //   textAlign: TextAlign.center,
                  // ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                // "Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space instead of being sized to their natural size"
                //     "Consider applying a flex factor (e.g. using an Expanded widget) to force the children of the RenderFlex to fit within the available space instead of being sized to their natural size",
                 widget.question,

                style: TextStyle(fontSize: 14, fontStyle: FontStyle.italic),
                textAlign: TextAlign.center,
              //  maxLines: 5,
                // overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),

              // if (false
              // //widget.isSelected && widget.showSlider
              // )
              //   Positioned(
              //     left: 0,
              //     right: 0,
              //     bottom: true ? 12 : 8,
              //     child: Padding(
              //       padding: EdgeInsets.symmetric(horizontal: true ? 16 : 8),
              //       child: _buildHoursControls(
              //         questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey),
              //         10,
              //         10,
              //         //sliderHeight, buttonIconSize
              //       ),
              //     ),
              //   ),
              if (false
              //  widget.isSelected && questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey ) > 0
              )
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
                        widget.isSelected = false;
                        questionProviderPrincipal.removeAnswerFromSheet(questionKey: widget.questionKey);

                        // setState(() {
                        //   widget.defaultHouer = null;
                        // });
                      },
                      child: Container(
                        decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle, border: Border.all(color: Colors.red, width: 1)),
                        padding: const EdgeInsets.all(4),
                        child: Icon(Icons.clear, size: MediaQuery.of(context).size.width > 1000 ? 16 : 8, color: Colors.red),
                      ),
                    ),
                  ),
                ),

              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         margin: EdgeInsets.all(10),
              //
              //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary, ),
              //         height: 50,
              //
              //         //width: 200,
              //         child: Center(child: Text('Select Hour', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         margin: EdgeInsets.all(10),
              //
              //         decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: AppColors.primary, ),
              //         height: 50,
              //
              //         //width: 200,
              //         child: Center(child: Text('Select Min', style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center)),
              //       ),
              //     ),
              //   ],
              // ),

              ///  cuppertino hour and time picker
              HourMinutePicker(
                onChanged: (hour, min) {
                  print("Hour: $hour   Min: $min");
                  /// update answers
                  setState(() {

                    _localHours = hour.toDouble();
                    _localMins= min.toDouble();
                  });
                  // questionProviderPrincipal.updateAnswer( hour: hour.toDouble(), questionKey: widget.questionKey, minute: min.toDouble());
                },
              ),
              SizedBox(height: 20),
              SizedBox(
                height: 20,
              ),
              ///  bottom buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Optional rounded corners
                        ),
                      ),
                      onPressed: (){

                        Navigator.pop(context);
                      }, child: Text("Cancel",style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),))  ,
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Optional rounded corners
                        ),
                      ),
                      onPressed: (){

                        questionProviderPrincipal.updateAnswer( hour:_localHours??0.0, questionKey: widget.questionKey, minute: _localMins??0.0 );
                        Navigator.pop(context);
                      }, child: Text("Submit",style: TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),))  ,


                ],

              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        );
      },
    );
  }

  // Widget _buildHoursControls(double currentValue, double sliderHeight, double buttonIconSize) {
  //   return Builder(
  //     builder:
  //         (context) => Row(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             // Minus button
  //             InkWell(
  //               onTap: () {
  //                 if (currentValue > 0) {
  //                   final newVal = (currentValue - 0.5).clamp(1, 24).toDouble();
  //                   questionProviderPrincipal.updateAnswer(key: "hour", value: newVal, questionKey: widget.questionKey);
  //                   print("currentValue");
  //                   print(currentValue);
  //                 }
  //                 print("currentValue");
  //                 print(currentValue);
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.all(sliderHeight / 9),
  //                 decoration: BoxDecoration(color: currentValue <= 0 ? Colors.grey.shade200 : AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
  //                 child: Icon(Icons.remove, size: buttonIconSize, color: currentValue <= 0 ? Colors.grey.shade400 : AppColors.primary),
  //               ),
  //             ),
  //             Expanded(
  //               child: SizedBox(
  //                 height: sliderHeight,
  //                 child: SliderTheme(
  //                   data: SliderTheme.of(context).copyWith(
  //                     trackHeight: sliderHeight / 7,
  //                     thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
  //                     overlayShape: RoundSliderOverlayShape(overlayRadius: sliderHeight / 1.4),
  //                     tickMarkShape: SliderTickMarkShape.noTickMark,
  //                     activeTrackColor: Color(0xFF007bb7),
  //                     inactiveTrackColor: AppColors.lightGray,
  //                     thumbColor: Color(0xFF007bb7),
  //                     overlayColor: Colors.transparent,
  //                   ),
  //                   child: Slider(
  //                     value: questionProviderPrincipal.getHoursByKey(questionKey: widget.questionKey),
  //                     min: 1,
  //                     max: 24,
  //                     divisions: 48,
  //                     // For 0.5 increments
  //                     onChanged: (value) {
  //                       questionProviderPrincipal.updateAnswer(key: "hour", value: value, questionKey: widget.questionKey);
  //
  //                       //  setState(() => _localHours = value);
  //                     },
  //                     onChangeEnd: (value) {
  //                       widget.defaultHours = value.toDouble();
  //                       questionProviderPrincipal.updateAnswer(key: "hour", value: value.toDouble(), questionKey: widget.questionKey);
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             // Plus button
  //             InkWell(
  //               onTap: () {
  //                 if (currentValue < 24) {
  //                   final newVal = (currentValue + 0.5).clamp(1, 24).toDouble();
  //                   questionProviderPrincipal.updateAnswer(key: "hour", value: newVal, questionKey: widget.questionKey);
  //                 }
  //               },
  //               child: Container(
  //                 padding: EdgeInsets.all(sliderHeight / 9),
  //                 decoration: BoxDecoration(color: currentValue >= 24 ? Colors.grey.shade200 : AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(4)),
  //                 child: Icon(Icons.add, size: buttonIconSize, color: currentValue >= 24 ? Colors.grey.shade400 : AppColors.primary),
  //               ),
  //             ),
  //           ],
  //         ),
  //   );
  // }
}
