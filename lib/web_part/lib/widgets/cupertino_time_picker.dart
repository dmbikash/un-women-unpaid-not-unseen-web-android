import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unwomen_unpaid_not_unseen/design/themes/colors.dart';

class HourMinutePicker extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final Function(int hours, int minutes) onChanged;

  const HourMinutePicker({
    super.key,
    this.initialHour = 0,
    this.initialMinute = 30,
    required this.onChanged,
  });

  @override
  State<HourMinutePicker> createState() => _HourMinutePickerState();
}

class _HourMinutePickerState extends State<HourMinutePicker> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();

    selectedHour = widget.initialHour;
    selectedMinute = widget.initialMinute;
   //  widget.onChanged(selectedHour,selectedMinute,);

  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Fixed height for the picker
      child: Row(
        children: [
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 5,bottom: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.withOpacity(.1)),
              child: Column(
                children: [
                  Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Hour", style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold, fontSize: 18),),
                          ),
                        ],
                      ),
                    ],
                  ),

                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      scrollController:
                      FixedExtentScrollController(initialItem: selectedHour),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          selectedHour = value;
                        });
                        widget.onChanged(selectedHour, selectedMinute);
                      },
                      children: List.generate(24, (index) => Center(
                        child: Text(
                          "$index h",
                          style: const TextStyle(fontSize: 18),
                        ),
                       ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10,),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 10,left: 10,right: 5,bottom: 10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.blue.withOpacity(.1)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Minute", style: TextStyle(color: AppColors.primary,fontWeight: FontWeight.bold, fontSize: 18),),
                  ),

                  Expanded(
                    child: CupertinoPicker(
                      itemExtent: 40,
                      scrollController:
                      FixedExtentScrollController(initialItem: selectedMinute),
                      onSelectedItemChanged: (value) {
                        setState(() {
                          selectedMinute = value;
                        });
                        widget.onChanged(selectedHour, selectedMinute);
                      },
                      children: List.generate(60, (index) => Center(
                        child: Text(
                          "$index m",
                          style: const TextStyle(fontSize: 18),
                        ),
                       ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
