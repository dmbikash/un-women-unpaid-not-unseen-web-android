import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class QuestionProviderPrincipal with ChangeNotifier {

  TextEditingController userName = TextEditingController();

  String? selectedGender = null;

  List<Map> answerSheet = [];

  Map answerSample = {"task_name": "task name", "question": "question", "answer": false, "gender": "Male", "point": 0, "hour": 1.5, "total_point": 0.0};

  void addAnswer({
    required String questionKey,
    required String question,
    required bool answer,
    required String gender,
    required int point,
    required double hour,
    required double totalPoint,
  }) {
    Map answerSample = {
      "question_key": "task name",
      "question": "question",
      "answer": false,
      "gender": "Male",
      "point": 0,
      "hour": 1.5,
      "total_point": 0.0,
    };
    answerSample = {
      "question_key": questionKey,
      "question": question,
      "answer": answer,
      "gender": gender,
      "point": point,
      "hour": hour,
      "total_point": totalPoint,
    };

    print("---------");
    answerSheet.add(answerSample);
    print(answerSheet);

  }

  double getGrandTotalPoint(){
    double sum=0;
    for(var anser in answerSheet){
      sum = sum+anser["total_point"];
    }
    return sum;
  }
  double getGrandTotalHour(){
    double sum=0;
    for(var anser in answerSheet){
      sum = sum+anser["hour"];
    }
    return sum;
  }

  void reset(){
    answerSheet = [];
    userName.clear();
    selectedGender=null;
   // notifyListeners();
  }
  void initStart(){
    answerSheet = [];
  }
}
