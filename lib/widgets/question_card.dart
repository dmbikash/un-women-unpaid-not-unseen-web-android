import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../controller/routes.dart';
import '../design/themes/colors.dart';
import '../design/text/textStyles.dart';
import '../services/languages.dart';
import '../models/question.dart';
import 'question_progress.dart';
import 'hour_option_selector.dart';
import 'package:provider/provider.dart';
import '../providers/question_provider_old.dart';
import '../services/language_service.dart';

class QuestionCard extends StatefulWidget {
  //final Question question_old;
  final String question;
  final String title;
  final int currentQuestionIndex;
  final int totalQuestions;

  // Update callback to accept double? instead of int? for decimal hours
  final Function(String title, String question, bool answer, double hour) onAnswer;

  final String logo;

  const QuestionCard({
    super.key,
    //required this.question_old,
    required this.question,
    required this.title,
    required this.onAnswer,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.logo,
  });

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  bool _processingAnswer = false;
  bool _showWorkTimeSlider = false;

  @override
  void initState() {
    super.initState();
  }

  void _navigateToResults() {
    Navigator.of(context).pushReplacementNamed(AppRoutes.result, );

  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final cardWidth = screenWidth; //* 0.85;
    final cardPadding = screenWidth * 0.04;
    //final questionProvider = Provider.of<QuestionProvider_old_app>(context);
    final langService = Provider.of<LanguageServiceMobile>(context);

    // Get question text from language file
    //final String questionText = ;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: Container(
            margin: EdgeInsets.all(10),
            width: cardWidth,
            // height: screenHeight,
            decoration: BoxDecoration(
              color: AppColors.background,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: Offset(0, screenHeight * 0.005))],
            ),
           // duration: Duration(seconds: 2),
            child: Padding(
              padding: EdgeInsets.all(cardPadding),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Logo at the top
                    if (false)
                      Image.asset(
                        'assets/logo/unpaid_not_unseen.png',
                        height: screenHeight * 0.06, // 6% of screen height
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.help_outline, size: screenWidth * 0.1, color: Colors.white),
                      ),

                    if (false) SizedBox(height: screenHeight * 0.02),
                    // 2% of screen height

                    // Box-style progress
                    QuestionProgress(currentQuestion: (widget.currentQuestionIndex+1), totalQuestions: widget.totalQuestions,),

                    SizedBox(height: screenHeight * 0.02),

                    // Question icon
                    Image.asset(
                      widget.logo,
                      height: screenHeight * 0.1, // 10% of screen height
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.help_outline, size: screenWidth * 0.1, color: Colors.white),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    // Question text
                    Container(
                      height: 120,
                      //color: Colors.red,
                      child: Center(
                        child: Text(
                          widget.question,
                          style: ThemeTextStyles.normalTitle.copyWith(
                            fontSize: 20, // 4.5% of screen width
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 4,
                        ),
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.025),

                    /// Yes/No buttons
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                              setState(() {
                                _showWorkTimeSlider = true ;
                              });

                              if (!_processingAnswer) {
                                setState(() {
                                  _processingAnswer = true;
                                });

                                // Clear any previously selected hours for this question
                               // questionProvider.resetCurrentHourSelection();

                                // Show hour options
                               // questionProvider.showHourSelection();

                                // Make the processing flag false after a delay
                                // but don't hide the hour options
                                Future.delayed(Duration(milliseconds: 50), () {
                                  if (mounted) {
                                    setState(() {
                                      _processingAnswer = false;
                                    });
                                  }
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              elevation: 0,
                              minimumSize: const Size(20, 40),
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(i18n[langService.currentLanguage]?['answers']?['yes'] ?? "Yes", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                        SizedBox(width: screenHeight * 0.015),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {

                              // Prevent double submissions
                             // if (!_processingAnswer) {
                                // setState(() {
                                //   _processingAnswer = true;
                                // });

                                // Hide hour options if they're showing

                                // if (questionProvider.showHourOptions) {
                                //   questionProvider.resetHourSelectionForNextQuestion();
                                // }

                                // Special handling for last question
                                // if (widget.question_old.id == '11') {
                                //   if (kDebugMode) {
                                //     print(
                                //       "DEBUG: No pressed on last question - direct navigation");
                                //   }
                                // }

                                // Answer No, no hours selection
                              setState(() {
                                _showWorkTimeSlider = false;
                              });
                                widget.onAnswer( widget.title,widget.question,  false,  0);

                                // Reset processing flag after a short delay to prevent rapid clicks
                                ///
                                // Future.delayed(Duration(milliseconds: 50), () {
                                //   if (mounted) {
                                //     setState(() {
                                //       _processingAnswer = false;
                                //     });
                                //   }
                                // });
                            //  }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8D8D8D),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              minimumSize: const Size(60, 40),
                              padding: EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                            child: Text(i18n[langService.currentLanguage]?['answers']?['no'] ?? "No", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 20),

                    // Hour selection - no animation
                 if(_showWorkTimeSlider)   HourOptionSelector(
                      //options: widget.question_old.hourOptions!,
                      visible: true,
                      onHourSelected: (hours) {
                        // setState(() {
                        //   _processingAnswer = true;
                        // });

                        // Process selection and move to next question with decimal hours
                        widget.onAnswer(widget.title, widget.question,  true,  hours);
                        setState(() {
                          _showWorkTimeSlider = false;
                        });

                        // Reset processing flag without delay
                        // setState(() {
                        //   _processingAnswer = false;
                        // });
                      },
                    ),

                    //SizedBox(height: 5,),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
