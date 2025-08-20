import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class QuestionProviderPrincipal with ChangeNotifier {
  TextEditingController userName = TextEditingController(text: kDebugMode? "Tester":"");

  String? selectedGender = kDebugMode? "Woman":null;
  double defaultHour = 0;
  double defaultMinute = 30;

  List<Map> answerSheet = [];
/*
    Map answerSample = {
    "task_name": "task name",
    "question": "question",
    "answer": false,
    "gender": "Male",
    "point": 0,
    "hour": 1.5,
    "total_point": 0.0,
  };
*/
  void addAnswer({
    required String questionKey,
    required String question,
    required bool answer,
    required String gender,
    required int point,
    required double hour,
    required double minute,
    required double totalPoint,
  }) {
    Map answerSample = {
      "question_key": "task name",
      "question": "question",
      "answer": false,
      "gender": "Male",
      "point": 0,
      "hour": 0.0,
      "minute": 0.0,
      "total_duration": 0.0,
      "total_point": 0.0,
    };
    answerSample = {
      "question_key": questionKey,
      "question": question,
      "answer": answer,
      "gender": gender,
      "point": point,
      "hour": hour,
      "minute": minute,
      "total_duration": hour+(minute/60),

      "total_point": totalPoint,
    };

    print("---------");

    if (answerSheet.any((element) {
      return element.containsValue(questionKey);
    })) {
      /// do nothing
    } else {
      answerSheet.add(answerSample);
    }
    print(answerSheet);
  }

  void updateAnswer({
    //required String key,
    required double hour,
    required double minute,
    required String questionKey,
  }) {
    int index = answerSheet.indexWhere((map) => map.containsValue(questionKey));
    if (index != -1) {
      // Key exists — update the value

      answerSheet[index]["hour"] = hour;
      answerSheet[index]["minute"] = minute;
      double totalDuration = hour+(minute/60);
      answerSheet[index]["total_duration"] = totalDuration;
      answerSheet[index]["total_point"] = totalDuration * (selectedGender=="Man" || selectedGender==null ? 60:50);
      print(answerSheet);
      notifyListeners();
    } else {
      // Key not found
      print("value: '$hour' not found in any map");
    }
  }

  void removeAnswerFromSheet({required String questionKey}) {
    int index = answerSheet.indexWhere((map) => map.containsValue(questionKey));
    if (index != -1) {
      // Key exists — update the value
      answerSheet.removeAt(index);
      print(answerSheet);
      notifyListeners();
    } else {
      // Key not found
      print("value '$questionKey' not found in any map");
    }
    // notifyListeners();
  }

  double getTotalHoursByKey({required String questionKey}) {
    int index = answerSheet.indexWhere((map) => map.containsValue(questionKey));
    if (index != -1) {
      // Key exists — update the value
      // double  hour = answerSheet[index]["hour"]?? 0.0;
      // double  minute = answerSheet[index]["minute"]?? 0.0;
      // double  time = answerSheet[index]["time"]?? 0.0;
      print("getHoursByKey : ${answerSheet[index]["total_duration"]}");
      return answerSheet[index]["total_duration"];
    } else {
      // Key not found
      return 0.0;
      print("value '$questionKey' not found in any map");
    }
    // notifyListeners();
  }

  double getHoursByKey({required String questionKey}) {
    int index = answerSheet.indexWhere((map) => map.containsValue(questionKey));
    if (index != -1) {
      // Key exists — update the value
      // double  hour = answerSheet[index]["hour"]?? 0.0;
      // double  minute = answerSheet[index]["minute"]?? 0.0;
      // double  time = answerSheet[index]["time"]?? 0.0;
      print("getHoursByKey : ${answerSheet[index]["hour"]}");
      return answerSheet[index]["hour"];
    } else {
      // Key not found
      print("returning default hour");
      return defaultHour;
      print("value '$questionKey' not found in any map");
    }
    // notifyListeners();
  }

  double getMinutesByKey({required String questionKey}) {
    int index = answerSheet.indexWhere((map) => map.containsValue(questionKey));
    if (index != -1) {
      // Key exists — update the value
      // double  hour = answerSheet[index]["hour"]?? 0.0;
      // double  minute = answerSheet[index]["minute"]?? 0.0;
      // double  time = answerSheet[index]["time"]?? 0.0;
      print("getMinutesByKey : ${answerSheet[index]["minute"]}");
      return answerSheet[index]["minute"] ==0? defaultMinute : answerSheet[index]["minute"] ;
    } else {
      print("returning default min");
      return defaultMinute;

      print("value '$questionKey' not found in any map");
    }
    // notifyListeners();
  }

  double getGrandTotalPoint() {
    double sum = 0;
    for (var anser in answerSheet) {
      sum = sum + anser["total_point"];
    }
    print(" Grand Total : $sum");
    return sum;
  }

  double getGrandTotalHour() {
    double sum = 0;
    for (var anser in answerSheet) {
      sum = sum + anser["total_duration"];
    }
    return sum;
  }

  void reset() {
    answerSheet = [];
    userName.clear();
    selectedGender = null;
    // notifyListeners();
  }

  void initStart() {
    answerSheet = [];
  }

  void refresh() {
    notifyListeners();
  }

  ///  web implementation
}
