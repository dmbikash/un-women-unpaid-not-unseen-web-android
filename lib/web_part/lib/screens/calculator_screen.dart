import 'package:unwomen_unpaid_not_unseen/controller/routes.dart';
import 'package:unwomen_unpaid_not_unseen/views/landing_page.dart';


import '../../../entities/questions.dart';
import '../../../providers/question_provider_principal.dart';
import '../../../services/language_service.dart';
import '../../../services/languages.dart';

import '../../../widgets/dropdowns.dart';
import '../constants/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import '../widgets/task_card.dart';
import '../providers/calculator_provider.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  double? _leftPanelHeight;
  int? _lastTaskCount;


  late QuestionProviderPrincipal questionProviderPrincipal;
  @override
  void initState() {
    questionProviderPrincipal = Provider.of<QuestionProviderPrincipal>(
      context,
      listen: false,
    );
    // TODO: implement initState
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final isTablet = size.width > 600;
    final isMobile = size.width < 500;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [

            /// appbar
            Text(
              'Unpaid Work Calculator',
              style: AppTextStyles.h1(context, color: Colors.white),
            ),
            const SizedBox(width: 12),
            Container(
              height: 28,
              width: 1.5,
              color: Colors.white,
              margin: const EdgeInsets.symmetric(horizontal: 8),
            ),
            Image.asset(
              'assets/logo/un_woman.png',
              height: 32,
              fit: BoxFit.contain,
              color: Colors.white,
            ),
          ],
        ),
        actions: [

        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {

          /// body

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16)),
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/logo/unpaid_not_unseen.png',
                            height: 100,
                            fit: BoxFit.contain,

                          ),

                          const SizedBox(height: 24),
                          // Main content layout - responsive
                          // isMobile
                          //     ? _buildMobileLayout(calculatorProvider)
                          //     :
                          _buildDesktopLayout(
                              isTablet),
                          // _buildMobileLayout(calculatorProvider),
                          const SizedBox(height: 24),

                          /// bottom section
//                           Image.asset(
//                             'assets/logo/unpaid_not_unseen.png',
//                             height: 100,
//                             fit: BoxFit.contain,
//
//                           ),
                          Text(
                            'Unpaid Work Calculator',
                            style: AppTextStyles.h1(context),
                          ),
                          const SizedBox(height: 40),
                          // Information sections - responsive

                          /// bottom part

                          Wrap(
                            spacing: 24,
                            runSpacing: 24,
                            alignment: WrapAlignment.center,
                            children: [
                              SizedBox(
                                width: isTablet ? 400 : double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      'What is Unpaid Care Work?',
                                      style: AppTextStyles.h2(context),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'Unpaid work includes cooking, cleaning, childcare, eldercare, and countless other tasks that keep families and communities functioning. This work is essential but often undervalued and unrecognized.',
                                      style: AppTextStyles.normal(context),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: isTablet ? 400 : double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment
                                      .start,
                                  children: [
                                    Text(
                                      'Why Calculate Its Value?',
                                      style: AppTextStyles.h2(context),
                                    ),
                                    const SizedBox(height: 12),
                                    Text(
                                      'By putting a value on unpaid care work, we can better understand its economic contribution and advocate for policies that recognize and support care workers.',
                                      style: AppTextStyles.normal(context),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDesktopLayout(bool isTablet) {
    final langService = Provider.of<LanguageServiceMobile>(context);
    final leftKey = GlobalKey();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final ctx = leftKey.currentContext;
      if (ctx != null) {
        final panelHeight = ctx.size?.height;
        final visibleTasks = questionList.length;
        if (panelHeight != null && (_leftPanelHeight != panelHeight ||
            _lastTaskCount != visibleTasks)) {
          setState(() {
            _leftPanelHeight = panelHeight;
            _lastTaskCount = visibleTasks;
          });
        }
      }
    });

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// select your care work tasks
        Expanded(
          //flex: isTablet ? 1 : 3,

          child: Container(
            key: leftKey,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(
                horizontal: 16, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select Your Care Work Tasks \nGive Total Work Hours (Weekly)',
                  style: AppTextStyles.h2(context),
                ),
                const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: isTablet ? 3 : 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: questionList.length,
                  itemBuilder: (context, index) {
                    final task = questionList[index];
                    return TaskCard(
                      title: i18n[langService
                          .currentLanguage]?["activity_names"]?[questionList[index]["question_key"]],
                      imagePath: questionList[index]["imagePath"],
                      defaultHours: 3 as double,
                      isSelected: false,
                      currentIndex: index,
                      question: i18n[langService
                          .currentLanguage]?["questions"]?[questionList[index]["question_key"]],
                      questionKey: questionList[index]["question_key"],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 24),

        /// your unpaid work value
        Expanded(
          //  flex: isTablet ? 1 : 2,
          child: Container(
            height: _leftPanelHeight,
            decoration: BoxDecoration(
              color: const Color(0xFF0099D8),
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Your Unpaid Work Value',
                  style: AppTextStyles.h2(context, color: Colors.white),
                ),
                // const SizedBox(height: 8),
                // Text(
                //   'Your Name',
                //   style: AppTextStyles.normal(context, color: Colors.white),
                // ),
                const SizedBox(height: 8),
                Consumer<QuestionProviderPrincipal>(
                  builder: (context,questionProvider, child) {
                    return Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: questionProvider.userName,
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
                              ),
                            ),
                          ),
                          Expanded(child: buildDropdown(
                            "Gender",  questionProvider.selectedGender, ["Woman", "Man"], (gender,) {
                            questionProvider.selectedGender = gender;
                            questionProvider.refresh();
                          },
                          )),
                        ],
                    );
                  }
                ),
                const SizedBox(height: 8),
                Consumer<QuestionProviderPrincipal>(
                  builder: (context, questionProvider, child) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF9FAFB),
                          ),
                          child: Column(
                            children: [
                              Text(
                                questionProvider.getGrandTotalHour().toStringAsFixed(1),
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Color(0xff2599D8)),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                'Total Hours',
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xff2599D8)),

                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFF9FAFB),
                          ),
                          child: Column(
                            children: [
                              Text(
                                questionProvider.getGrandTotalPoint().toString(),
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 28,
                                    color: Color(0xff2599D8)),
                              ),
                              SizedBox(height: 15,),
                              Text(
                                'Total Points',
                                // style: AppTextStyles.normal(context, color: Colors.white),
                                style: TextStyle(fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Color(0xff2599D8)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                ),

                const SizedBox(height: 8),
                Text(
                  'Based on the HPRA research in Bangladesh for Women',
                  style: AppTextStyles.normal(context, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                if (false)
                  LayoutBuilder(
                    builder: (context, constraints) {
                      const double maxChipHeight = 100.0;
                      final chipCount = 2;
                      final estRows = (chipCount / 4.0).ceil();
                      final naturalHeight = 16.0 + (estRows * 36.0) + 16.0;
                      final useScroll = naturalHeight > maxChipHeight;
                      return Container(
                        margin: const EdgeInsets.only(bottom: 18),
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.13),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.white24),
                        ),
                        //height: useScroll ? maxChipHeight : null,
                        child: Text("chip will be here"),
                        //   useScroll
                        //       ? SingleChildScrollView(
                        //     child: _chipWrap(provider),
                        //   )
                        //       : _chipWrap(provider),
                      );
                    },
                  ),
                const SizedBox(height: 8),
                if (true) Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        "do something";
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(
                            0xFF0099D8), // or your preferred color
                      ),
                      icon: const Icon(
                        Icons.refresh, color: Color(0xFF0099D8),),
                      label: Text(
                        'Reset Values',
                        style: AppTextStyles.buttonText(context, color: Color(
                            0xFF0099D8)),
                      ),
                    ),
                    SizedBox(width: 15,),

                    SizedBox(
                      //width: MediaQuery.of(context).size.width * 0.92,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(WebRoutes
                              .webResult,);
                          // print(
                          //     'View Result pressed: arguments = {scores: $usedScores, totalScore: $usedTotalScore, hoursByQuestion: $usedHoursByQuestion, name: ${provider
                          //         .nameController.text}, totalHours: ${provider
                          //         .totalHours}, totalValue: ${provider
                          //         .totalPoints}, selectedTasks: ${provider
                          //         .selectedTasks}}');
                          // Navigator.pushNamed(
                          //   context,
                          //   '/result',
                          //   arguments: {
                          //     'name': provider.nameController.text,
                          //     'totalHours': provider.totalHours,
                          //     'totalValue': provider.totalPoints,
                          //     'selectedTasks': provider.selectedTasks,
                          //     'scores': usedScores,
                          //    // 'totalScore': usedTotalScore,
                          //     'totalScore': provider.totalPoints,
                          //     'hoursByQuestion': usedHoursByQuestion,
                          //     'taskNames': {
                          //       for(final t in questionList) t['title']: t['title']
                          //     },
                          //   },
                          // );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Color(0xFF0099D8),
                          padding: const EdgeInsets.symmetric(horizontal: 24,
                              vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        icon: Icon(Icons.list),
                        label: Text(
                          'View Result',
                          style: AppTextStyles.buttonText(context,
                              color: Color(0xFF0099D8)),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),

              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _chipWrap(CalculatorProvider provider) {
    return Wrap(
      spacing: 10,
      runSpacing: 8,
      children: provider.selectedTasks.entries.map((entry) =>
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  entry.key,
                  style: AppTextStyles.normal(context),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8, vertical: 1),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${entry.value.toStringAsFixed(1)}h',
                    style: AppTextStyles.normal(context),
                  ),
                ),
              ],
            ),
          )
      ).toList(),
    );
  }


  // Widget _buildMobileLayout(CalculatorProvider provider) {
  //   return Column(
  //     children: [
  //       // Results panel
  //       Container(
  //         width: double.infinity,
  //         decoration: BoxDecoration(
  //           color: const Color(0xFF0099D8),
  //           borderRadius: BorderRadius.circular(16),
  //         ),
  //         padding: const EdgeInsets.all(24),
  //         child: Column(
  //           children: [
  //             Text(
  //               'Your Unpaid Work Value',
  //               style: AppTextStyles.h2(context),
  //             ),
  //             const SizedBox(height: 16),
  //             Text(
  //               'Your Name',
  //               style: AppTextStyles.normal(context,color: Colors.white),
  //             ),
  //             const SizedBox(height: 8),
  //             TextField(
  //               controller: provider.nameController,
  //               decoration: InputDecoration(
  //                 hintText: 'Enter your name',
  //                 filled: true,
  //                 fillColor: Colors.white,
  //                 border: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(8),
  //                   borderSide: BorderSide.none,
  //                 ),
  //               ),
  //             ),
  //             const SizedBox(height: 24),
  //             Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //               children: [
  //                 Column(
  //                   children: [
  //                     Text(
  //                       provider.totalHours.toStringAsFixed(1),
  //                       style: AppTextStyles.h2(context,color: Colors.white),
  //                     ),
  //                     Text(
  //                       'Hours',
  //                       style: AppTextStyles.normal(context,color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //                 Column(
  //                   children: [
  //                     Text(
  //                       provider.totalPoints.toString(),
  //                       style: AppTextStyles.h2(context,color: Colors.white),
  //                     ),
  //                     Text(
  //                       'Points',
  //                       style: AppTextStyles.normal(context,color: Colors.white),
  //                     ),
  //                   ],
  //                 ),
  //               ],
  //             ),
  //             const SizedBox(height: 16),
  //             Image.asset(
  //               'assets/logo/unpaid_not_unseen.png',
  //               height: 60,
  //               fit: BoxFit.contain,
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 24),
  //
  //       // Task selection
  //       Column(
  //         crossAxisAlignment: CrossAxisAlignment.start,
  //         children: [
  //           Text(
  //             'Select Your Care Work Tasks',
  //             style: AppTextStyles.h2(context),
  //             textAlign: TextAlign.left,
  //           ),
  //           const SizedBox(height: 16),
  //           GridView.builder(
  //             shrinkWrap: true,
  //             physics: const NeverScrollableScrollPhysics(),
  //             gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
  //               crossAxisCount: 2,
  //               crossAxisSpacing: 12,
  //               mainAxisSpacing: 12,
  //               childAspectRatio: 0.8,
  //             ),
  //             itemCount: questionList.length,
  //             itemBuilder: (context, index) {
  //               final task = questionList[index];
  //               return TaskCard(
  //                 title: task['title'] as String,
  //                 imagePath: task['imagePath'] as String,
  //                 defaultHours: task['defaultHours'] as double,
  //                 isSelected: provider.selectedTasks.containsKey(task['title']), question: '', questionKey: '', currentIndex: null,
  //               );
  //             },
  //           ),
  //         ],
  //       ),
  //     ],
  //   );
  // }


}