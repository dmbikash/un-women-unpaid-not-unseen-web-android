import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unwomen_unpaid_not_unseen/providers/question_provider_principal.dart';
import '../design/themes/colors.dart';

import '../entities/questions.dart';
import '../web_part/lib/providers/calculator_provider.dart';
import '../widgets/question_card.dart';
import '../controller/routes.dart';
import '../data/questions.dart';
import '../providers/question_provider_old.dart';
import '../widgets/page_scaffold.dart';
import '../services/language_service.dart';
import '../services/languages.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  // Flag to prevent multiple navigations
  bool _isNavigating = false;
  
  late QuestionProviderPrincipal questionProviderPrincipal ;

 @override
  void initState() {
    
   questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(context,listen: false);
   
   // TODO: implement initState
    super.initState();
  }

  int totalQuestion = questionList.length;
  int index = 0;

  void incrementIndex(int index){
    if (this.index < totalQuestion-1) {
      setState(() {
        this.index = index+1;
      });
    }
    print("index  $index");

  }

  @override
  Widget build(BuildContext context) {

   print("last index---$index");
    final langService = Provider.of<LanguageServiceMobile>(context);

    return PageScaffold(
      title: i18n[langService.currentLanguage]?['result_page']?['title'] ?? 'Unpaid Work Calculator',
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToResults( );
        },
      ),
      showBackButton: false,
      body:  Center(
        child: QuestionCard(
         // question_old:  Provider.of<QuestionProvider>(context, listen: false).currentQuestion,

          logo: questionList[index]["imagePath"],
          currentQuestionIndex: index,
          totalQuestions: totalQuestion,
          question: i18n[langService.currentLanguage]?["questions"]?[questionList[index]["question_key"]],
          title: questionList[index]["question_key"],
          onAnswer: (String title,String question, bool answer, double hour) {
            if (index < totalQuestion-1) {
              print("question : $question");
              print("answer : $answer");
              print("Hour : $hour");

                incrementIndex(index);

              int point = questionProviderPrincipal.selectedGender != null && questionProviderPrincipal.selectedGender=="Man" ? questionList[index]["points_men"]:  questionList[index]["points_women"];
              
              double totalPoint =point*hour ;
              questionProviderPrincipal.addAnswer(questionKey: title, question: question, answer: answer, gender: questionProviderPrincipal.selectedGender?? "Man",
                  point: point,
                  hour: hour,
                  totalPoint: totalPoint,
              );
            }else{
              _navigateToResults();
            }
          },



        ),
      ),
    );
  }

  // Method to safely navigate to results page
  void _navigateToResults() {

    Navigator.of(context).pushReplacementNamed(WebRoutes.result, );


  }
}
