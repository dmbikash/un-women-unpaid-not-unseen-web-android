// import '../constants/text_styles.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../screens/share_result_page.dart';
// import '../widgets/task_card.dart';
// import '../providers/calculator_provider.dart';
// import '../constants/app_colors.dart';
// import '../constants/gaps.dart';
//
//
// class UnpaidWorkCalculator extends StatefulWidget {
//   const UnpaidWorkCalculator({super.key});
//
//   @override
//   State<UnpaidWorkCalculator> createState() => _UnpaidWorkCalculatorState();
// }
//
// class _UnpaidWorkCalculatorState extends State<UnpaidWorkCalculator> {
//   Map<String, double> selectedTasks = {};
//   @override
//   Widget build(BuildContext context) {
//     final calculatorProvider = Provider.of<CalculatorProvider>(context);
//     final size = MediaQuery
//         .of(context)
//         .size;
//     //final isTablet = size.width > 600;
//     final isMobile = size.width < 500;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: AppColors.primary,
//         title: Row(
//           children: [
//             Image.asset(
//                 'assets/logo/un_woman.png', height: 40, color: AppColors.white),
//             Gaps.hSmall,
//             Text('WOMEN', style: AppTextStyles.h1(context).copyWith(
//                 fontWeight: FontWeight.bold)),
//             Gaps.hTiny,
//             Text('|', style: AppTextStyles.h1(context).copyWith(
//                 fontWeight: FontWeight.bold)),
//             Gaps.hTiny,
//             Text('COUNT', style: AppTextStyles.h1(context).copyWith(
//                 fontWeight: FontWeight.bold)),
//           ],
//         ),
//         actions: [
//           _buildNavButton('Calculator', true),
//           _buildNavButton('Report', false),
//           _buildNavButton('Share Your Story', false),
//           _buildNavButton('Campaign Info', false,
//               onTap: () => Navigator.pushNamed(context, '/campaign_info')),
//           _buildNavButton('Contact', false,
//               onTap: () => Navigator.pushNamed(context, '/contact')),
//         ],
//       ),
//       body: Container(
//         color: AppColors.lightGray,
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: Gaps.paddingMedium,
//             child: Center(
//               child: ConstrainedBox(
//                 constraints: const BoxConstraints(maxWidth: 1200),
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(16)),
//                   child: Padding(
//                     padding: Gaps.paddingLarge,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Text(
//                           'Invisible Payslip Calculator',
//                           style: AppTextStyles.h1(context),
//                         ),
//                         Gaps.vMedium,
//                         Container(
//                           width: double.infinity,
//                           padding: Gaps.paddingMedium,
//                           decoration: BoxDecoration(
//                             color: AppColors.errorLight,
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text(
//                             'Select your care work tasks to calculate your unpaid work value',
//                             textAlign: TextAlign.center,
//                             style: AppTextStyles.normal(context).copyWith(
//                                 color: AppColors.error),
//                           ),
//                         ),
//                         Gaps.vLarge,
//
//                         // Main content layout
//                         isMobile
//                             ? _buildMobileLayout(calculatorProvider)
//                             : IntrinsicHeight(
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               // Left column - Task selection
//                               Expanded(
//                                 flex: 3,
//                                 child: _buildTasksSection(calculatorProvider),
//                               ),
//                               Gaps.hLarge,
//                               // Right column - Payslip
//                               Expanded(
//                                 flex: 2,
//                                 child: _buildPayslipSection(calculatorProvider),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Gaps.vLarge,
//
//                         // Action buttons
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             ElevatedButton.icon(
//                               onPressed: calculatorProvider.resetCalculation,
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: AppColors.buttonSecondary,
//                                 foregroundColor: AppColors.white,
//                                 padding: Gaps.buttonPadding,
//                                 shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(30)),
//                               ),
//                               icon: const Icon(Icons.refresh),
//                               label: Text('Reset',
//                                   style: AppTextStyles.buttonText(context)),
//                             ),
//                             Gaps.hMedium,
//                             if (calculatorProvider.selectedTasks.isNotEmpty)
//                               ElevatedButton.icon(
//                                 onPressed: () {
//                                   if (calculatorProvider.nameController.text
//                                       .isEmpty) {
//                                     ScaffoldMessenger.of(context).showSnackBar(
//                                       SnackBar(content: Text(
//                                           'Please enter your name',
//                                           style: AppTextStyles.normal(
//                                               context))),
//                                     );
//                                     return;
//                                   }
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           ShareResultPage(
//                                             name: calculatorProvider
//                                                 .nameController.text,
//                                             totalHours: calculatorProvider
//                                                 .totalHours,
//                                             totalValue: calculatorProvider
//                                                 .totalPoints.toDouble(),
//                                             selectedTasks: Map<String,
//                                                 double>.from(calculatorProvider
//                                                 .selectedTasks),
//                                           ),
//                                     ),
//                                   );
//                                 },
//                                 style: ElevatedButton.styleFrom(
//                                   backgroundColor: Colors.grey.shade300,
//                                   foregroundColor: Colors.black87,
//                                   padding: Gaps.buttonPadding,
//                                   shape: RoundedRectangleBorder(
//                                       borderRadius: BorderRadius.circular(30)),
//                                 ),
//                                 icon: const Icon(Icons.description),
//                                 label: Text('Generate Payslip',
//                                     style: AppTextStyles.buttonText(context)),
//                               ),
//                           ],
//                         ),
//                         Gaps.vXXLarge,
//
//                         // Information sections
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Expanded(
//                               child: Card(
//                                 elevation: 2,
//                                 child: Padding(
//                                   padding: Gaps.paddingMedium,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Text(
//                                         'What is Unpaid Care Work?',
//                                         style: AppTextStyles.h3(context),
//                                       ),
//                                       Gaps.vSmall,
//                                       Text(
//                                         'Unpaid care work includes cooking, cleaning, childcare, eldercare, and countless other tasks that keep families and communities functioning. This work is essential but often invisible and undervalued.',
//                                         style: AppTextStyles.normal(context),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             Gaps.hMedium,
//                             Expanded(
//                               child: Card(
//                                 elevation: 2,
//                                 child: Padding(
//                                   padding: Gaps.paddingMedium,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment
//                                         .start,
//                                     children: [
//                                       Text(
//                                         'Why Calculate Its Value?',
//                                         style: AppTextStyles.h3(context),
//                                       ),
//                                       Gaps.vSmall,
//                                       Text(
//                                         'By putting a monetary value on unpaid care work, we can better understand its economic contribution and advocate for policies that recognize and support care workers.',
//                                         style: AppTextStyles.normal(context),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Navigation button widget
//   Widget _buildNavButton(String label, bool isActive, {VoidCallback? onTap}) {
//     return TextButton(
//       onPressed: onTap ?? () {},
//       style: TextButton.styleFrom(
//         backgroundColor: isActive ? AppColors.white.withOpacity(0.2) : Colors.transparent,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//         padding: Gaps.smallButtonPadding,
//       ),
//       child: Text(
//         label,
//         style: AppTextStyles.normal(context).copyWith(color: AppColors.white),
//       ),
//     );
//   }
//
// // Used scores calculation
//   Map<String, int> get usedScores {
//     final Map<String, int> scores = {};
//
//     // Calculate points for each selected task
//     for (var task in selectedTasks.entries) {
//       final String taskId = task.key;
//       final double hours = task.value;
//
//       // Get base points per hour for this task
//       final int basePoints = getTaskBasePoints(taskId);
//
//       // Calculate total points (hours * base points)
//       final int taskScore = (hours * basePoints).round();
//
//       scores[taskId] = taskScore;
//     }
//
//     return scores;
//   }
//
// // Helper method to get base points for a task
//   int getTaskBasePoints(String taskId) {
//     // Define point values for different tasks
//     // final Map<String, int> taskPoints = {
//     //   'Cooking': 100,
//     //   'Childcare': 150,
//     //   'Adult Care': 125,
//     //   'Cleaning': 75,
//     //   'Grocery Shopping': 50,
//     //   'Laundry': 60,
//     //   'Homework Help': 100,
//     //   'Emotional Support': 125,
//     //   'Gardening': 75,
//     //   'Water Collection': 50,
//     //   'Healthcare Support': 150,
//     //   'Other': 50
//     // };
//
//     //return taskPoints[taskId] ?? 50; // Default 50 points if task not found
//     return  50; // Default 50 points if task not found
//   }
//
// // Get total score
//   int get usedTotalScore {
//     return usedScores.values.fold(0, (sum, score) => sum + score);
//   }
//
// // Get hours by question
//   Map<String, double> get usedHoursByQuestion {
//     return Map<String, double>.from(selectedTasks);
//   }
//   Widget _buildTasksSection(CalculatorProvider provider) {
//     return Card(
//       elevation: 0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       child: Padding(
//         padding: Gaps.paddingMedium,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Select Your Care Work Tasks',
//               style: AppTextStyles.h3(context),
//               textAlign: TextAlign.left,
//             ),
//             Gaps.vMedium,
//             SizedBox(
//               height: 350,
//               child: GridView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                   childAspectRatio: 0.9,
//                 ),
//                 itemCount: _taskList.length,
//                 itemBuilder: (context, index) {
//                   final task = _taskList[index];
//                   return TaskCard(
//                     title: task['title'] as String,
//                     imagePath: task['imagePath'] as String,
//                     defaultHours: task['defaultHours'] as double,
//                     isSelected: provider.selectedTasks.containsKey(
//                         task['title']),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPayslipSection(CalculatorProvider provider) {
//     return Container(
//       decoration: BoxDecoration(
//         color: AppColors.primary,
//         borderRadius: BorderRadius.circular(8),
//       ),
//       padding: Gaps.paddingLarge,
//       child: Column(
//         children: [
//           Text(
//             'Your Invisible Payslip',
//             style: AppTextStyles.h3(context).copyWith(color: AppColors.white),
//           ),
//           Gaps.vMedium,
//           Text(
//             'Your Name',
//             style: AppTextStyles.lightText(context),
//           ),
//           Gaps.vSmall,
//           TextField(
//             controller: provider.nameController,
//             decoration: InputDecoration(
//               hintText: 'Enter your name',
//               filled: true,
//               fillColor: AppColors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//           Gaps.vXLarge,
//           Text(
//             '${provider.totalHours.toInt()}',
//             style: AppTextStyles.largeNumber(context),
//           ),
//           Text(
//             'Total Hours',
//             style: AppTextStyles.lightText(context),
//           ),
//           Gaps.vLarge,
//           Text(
//             '${provider.totalPoints.toInt()}',
//             style: AppTextStyles.largeNumber(context),
//           ),
//           Text(
//             'Total Value /hour',
//             style: AppTextStyles.lightText(context),
//           ),
//           Gaps.vLarge,
//           Container(
//             padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
//             decoration: BoxDecoration(
//               color: AppColors.white.withOpacity(0.2),
//               borderRadius: BorderRadius.circular(4),
//             ),
//             child: Text(
//               'Based on the HPSA research in Bangladesh UN Women',
//               style: AppTextStyles.small(context).copyWith(
//                   color: AppColors.white),
//               textAlign: TextAlign.center,
//             ),
//           ),
//           Gaps.vXXLarge,
//           Image.asset(
//             'assets/logo/unpaid_not_unseen.png',
//             height: 120,
//             fit: BoxFit.contain,
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildMobileLayout(CalculatorProvider provider) {
//     return Column(
//       children: [
//         // Results panel
//         Container(
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: AppColors.primary,
//             borderRadius: BorderRadius.circular(16),
//           ),
//           padding: Gaps.paddingLarge,
//           child: Column(
//             children: [
//               Text(
//                 'Your Invisible Payslip',
//                 style: AppTextStyles.h3(context).copyWith(
//                     color: AppColors.white),
//               ),
//               Gaps.vMedium,
//               Text(
//                 'Your Name',
//                 style: AppTextStyles.lightText(context),
//               ),
//               Gaps.vSmall,
//               TextField(
//                 controller: provider.nameController,
//                 decoration: InputDecoration(
//                   hintText: 'Enter your name',
//                   filled: true,
//                   fillColor: AppColors.white,
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(8),
//                     borderSide: BorderSide.none,
//                   ),
//                 ),
//               ),
//               Gaps.vLarge,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   Column(
//                     children: [
//                       Text(
//                         provider.totalHours.toStringAsFixed(1),
//                         style: AppTextStyles.largeNumber(context),
//                       ),
//                       Text(
//                         'Hours',
//                         style: AppTextStyles.lightText(context),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     children: [
//                       Text(
//                         provider.totalPoints.toString(),
//                         style: AppTextStyles.largeNumber(context),
//                       ),
//                       Text(
//                         'Points',
//                         style: AppTextStyles.lightText(context),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//               Gaps.vMedium,
//               Image.asset(
//                 'assets/logo/unpaid_not_unseen.png',
//                 height: 60,
//                 fit: BoxFit.contain,
//               ),
//             ],
//           ),
//         ),
//         Gaps.vLarge,
//
//         // Task selection
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               'Select Your Care Work Tasks',
//               style: AppTextStyles.h3(context),
//               textAlign: TextAlign.left,
//             ),
//             Gaps.vMedium,
//             SizedBox(
//               height: 400,
//               child: GridView.builder(
//                 physics: const AlwaysScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: 8,
//                   mainAxisSpacing: 8,
//                   childAspectRatio: 0.9,
//                 ),
//                 itemCount: _taskList.length,
//                 itemBuilder: (context, index) {
//                   final task = _taskList[index];
//                   return TaskCard(
//                     title: task['title'] as String,
//                     imagePath: task['imagePath'] as String,
//                     defaultHours: task['defaultHours'] as double,
//                     isSelected: provider.selectedTasks.containsKey(
//                         task['title']),
//                   );
//                 },
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   // Task list with default hours
//   final List<Map<String, dynamic>> _taskList = [
//     {
//       'title': 'Cooking',
//       'imagePath': 'assets/Image/cooking.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Childcare',
//       'imagePath': 'assets/Image/child_care.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Adult Care',
//       'imagePath': 'assets/Image/elder_care.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Cleaning',
//       'imagePath': 'assets/Image/cleaning.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Grocery Shopping',
//       'imagePath': 'assets/Image/grocery_shopping.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Laundry',
//       'imagePath': 'assets/Image/laundry.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Homework Help',
//       'imagePath': 'assets/Image/homework_help.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Emotional Support',
//       'imagePath': 'assets/Image/emotional_support.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Gardening',
//       'imagePath': 'assets/Image/gardening.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Water Collection',
//       'imagePath': 'assets/Image/water_collection.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Healthcare Support',
//       'imagePath': 'assets/Image/helthcare_support.png',
//       'defaultHours': 0.0,
//     },
//     {
//       'title': 'Other',
//       'imagePath': 'assets/Image/other.png',
//       'defaultHours': 0.0,
//     },
//   ];
// }