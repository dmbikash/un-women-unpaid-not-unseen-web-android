// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:share_plus/share_plus.dart';
// import 'dart:io';
// import 'package:path_provider/path_provider.dart';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
// import 'package:flutter/rendering.dart';
// import '../constants/text_styles.dart';
//
// class ShareResultScreen extends StatefulWidget {
//   final String name;
//   final double totalHours;
//   final double totalValue;
//   final Map<String, double> selectedTasks;
//
//   const ShareResultScreen({
//     super.key,
//     required this.name,
//     required this.totalHours,
//     required this.totalValue,
//     required this.selectedTasks,
//   });
//
//   @override
//   State<ShareResultScreen> createState() => _ShareResultScreenState();
// }
//
// class _ShareResultScreenState extends State<ShareResultScreen> {
//   final GlobalKey _chartKey = GlobalKey();
//   int touchedIndex = -1;
//   bool isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final List<Color> chartColors = [
//       Colors.blue,
//       Colors.red,
//       Colors.green,
//       Colors.orange,
//       Colors.purple,
//       Colors.teal,
//       Colors.pink,
//       Colors.amber,
//       Colors.cyan,
//       Colors.indigo,
//       Colors.lime,
//       Colors.deepOrange,
//     ];
//
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Your Results', style: AppTextStyles.h1(context)),
//         actions: [
//           TextButton.icon(
//             onPressed: _shareResults,
//             icon: const Icon(Icons.share, color: Colors.white),
//             label: Text('Share', style: AppTextStyles.normal(context).copyWith(
//                 color: Colors.white)),
//           ),
//           // PopupMenuButton(
//           //   itemBuilder: (context) =>
//           //   [
//           //     const PopupMenuItem(
//           //       value: 'calculate',
//           //       child: Text('Calculate'),
//           //     ),
//           //     const PopupMenuItem(
//           //       value: 'report',
//           //       child: Text('Report'),
//           //     ),
//           //     const PopupMenuItem(
//           //       value: 'campaign',
//           //       child: Text('Campaign Info'),
//           //     ),
//           //     const PopupMenuItem(
//           //       value: 'contact',
//           //       child: Text('Contact'),
//           //     ),
//           //   ],
//           //   onSelected: (value) {
//           //     // Handle menu selection
//           //   },
//           // ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Hello, ${widget.name}!',
//                         style: AppTextStyles.h1(context),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Your Invisible Work Summary',
//                         style: AppTextStyles.h2(context).copyWith(color: Theme
//                             .of(context)
//                             .primaryColor, fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           _buildSummaryItem(
//                             context,
//                             'Total Hours',
//                             widget.totalHours.toStringAsFixed(2),
//                             Icons.access_time,
//                           ),
//                           _buildSummaryItem(
//                             context,
//                             'Total Value',
//                             '${widget.totalValue.toStringAsFixed(0)} points',
//                             Icons.stars,
//                           ),
//                           _buildSummaryItem(
//                             context,
//                             'Tasks',
//                             widget.selectedTasks.length.toString(),
//                             Icons.task_alt,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 24),
//               Text(
//                 'Hours Spent by Task',
//                 style: AppTextStyles.h2(context).copyWith(
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 16),
//
//               // Pie Chart Container
//               Container(
//                 height: 300,
//                 padding: const EdgeInsets.all(16),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(16),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.withOpacity(0.1),
//                       blurRadius: 10,
//                       offset: const Offset(0, 5),
//                     ),
//                   ],
//                 ),
//                 child: RepaintBoundary(
//                   key: _chartKey,
//                   child: PieChart(
//                     PieChartData(
//                       pieTouchData: PieTouchData(
//                         touchCallback: (FlTouchEvent event, pieTouchResponse) {
//                           setState(() {
//                             if (!event.isInterestedForInteractions ||
//                                 pieTouchResponse == null ||
//                                 pieTouchResponse.touchedSection == null) {
//                               touchedIndex = -1;
//                               return;
//                             }
//                             touchedIndex = pieTouchResponse.touchedSection!
//                                 .touchedSectionIndex;
//                           });
//                         },
//                       ),
//                       borderData: FlBorderData(show: false),
//                       sectionsSpace: 2,
//                       centerSpaceRadius: isExpanded ? 0 : 40,
//                       sections: _createSections(chartColors),
//                     ),
//                   ),
//                 ),
//               ),
//
//               // Toggle button for chart display
//               Center(
//                 child: TextButton.icon(
//                   onPressed: () {
//                     setState(() {
//                       isExpanded = !isExpanded;
//                     });
//                   },
//                   icon: Icon(
//                     isExpanded ? Icons.pie_chart : Icons.donut_large,
//                   ),
//                   label: Text(
//                       isExpanded ? 'Show Donut Chart' : 'Show Full Pie Chart',
//                       style: AppTextStyles.normal(context)),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Task breakdown list
//               Card(
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Task Breakdown',
//                         style: AppTextStyles.h2(context).copyWith(
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 16),
//                       ...widget.selectedTasks.entries.map((entry) {
//                         final index = widget.selectedTasks.keys
//                             .toList()
//                             .indexOf(entry.key) % chartColors.length;
//                         return _buildTaskItem(
//                           entry.key,
//                           entry.value,
//                           chartColors[index],
//                         );
//                       }).toList(),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // Impact Statement
//               Card(
//                 color: Colors.lightBlue.shade50,
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '💡 Did you know?',
//                         style: AppTextStyles.h3(context).copyWith(
//                             fontWeight: FontWeight.bold),
//                       ),
//                       const SizedBox(height: 8),
//                       Text(
//                         'Your ${widget.totalHours.toStringAsFixed(
//                             2)} hours of unpaid care work have earned you ${widget
//                             .totalValue.toStringAsFixed(
//                             0)} points in recognition of your contribution.',
//                         style: AppTextStyles.normal(context),
//                       ),
//                       const SizedBox(height: 16),
//                       Text(
//                         'Unpaid care work is essential for families and communities, yet often goes unrecognized in economic measures.',
//                         style: AppTextStyles.small(context).copyWith(
//                             fontStyle: FontStyle.italic),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//
//               // Share button
//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: _shareResults,
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme
//                         .of(context)
//                         .primaryColor,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 32, vertical: 16),
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                   ),
//                   icon: const Icon(Icons.share),
//                   label: Text(
//                     'Share My Results',
//                     style: AppTextStyles.buttonText(context),
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 32),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSummaryItem(BuildContext context,
//       String title,
//       String value,
//       IconData icon,) {
//     return Column(
//       children: [
//         Icon(
//           icon,
//           color: Theme
//               .of(context)
//               .primaryColor,
//           size: 36,
//         ),
//         const SizedBox(height: 8),
//         Text(
//           value,
//           style: AppTextStyles.h2(context).copyWith(
//               fontWeight: FontWeight.bold),
//         ),
//         Text(
//           title,
//           style: AppTextStyles.small(context).copyWith(
//               color: Colors.grey.shade600),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildTaskItem(String taskName, double hours, Color color) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8),
//       child: Row(
//         children: [
//           Container(
//             width: 16,
//             height: 16,
//             decoration: BoxDecoration(
//               color: color,
//               shape: BoxShape.circle,
//             ),
//           ),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Text(taskName, style: AppTextStyles.normal(context)),
//           ),
//           Text(
//             '${hours.toStringAsFixed(2)} hours',
//             style: AppTextStyles.normal(context).copyWith(
//                 fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   List<PieChartSectionData> _createSections(List<Color> colors) {
//     return widget.selectedTasks.entries.map((entry) {
//       final index = widget.selectedTasks.keys.toList().indexOf(entry.key);
//       final isTouched = index == touchedIndex;
//       final fontSize = isTouched ? 20.0 : 16.0;
//       final radius = isTouched ? 110.0 : 100.0;
//       final color = colors[index % colors.length];
//
//       return PieChartSectionData(
//         color: color,
//         value: entry.value,
//         title: '${entry.value.toStringAsFixed(2)}h',
//         radius: radius,
//         titleStyle: TextStyle(
//           fontSize: fontSize,
//           fontWeight: FontWeight.bold,
//           color: Colors.white,
//         ),
//       );
//     }).toList();
//   }
//
//   Future<void> _shareResults() async {
//     try {
//       // Create a text summary
//       final String summary = '''
// Unpaid Work Results for ${widget.name}
//
// Total Hours: ${widget.totalHours.toStringAsFixed(2)}
// Total Points: ${widget.totalValue.toStringAsFixed(0)}
//
// Task Breakdown:
// ${widget.selectedTasks.entries.map((e) => '- ${e.key}: ${e.value
//           .toStringAsFixed(2)} hours').join(
//           '\n')}
//
// #UnpaidWorkMatters #UnpaidNotUnseen
//       ''';
//
//       // Capture the chart as an image
//       final RenderRepaintBoundary boundary = _chartKey.currentContext!
//           .findRenderObject() as RenderRepaintBoundary;
//       final ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//       final ByteData? byteData = await image.toByteData(
//           format: ui.ImageByteFormat.png);
//       if (byteData != null) {
//         final Uint8List pngBytes = byteData.buffer.asUint8List();
//
//         // Create a temporary file
//         final tempDir = await getTemporaryDirectory();
//         final file = File('${tempDir.path}/invisible_work_chart.png');
//         await file.writeAsBytes(pngBytes);
//
//         // Share the text and image
//         await Share.shareXFiles(
//           [XFile(file.path)],
//           text: summary,
//           subject: 'My Invisible Work Results',
//         );
//       } else {
//         // If image capture fails, share just the text
//         await Share.share(summary, subject: 'My Invisible Work Results');
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error sharing results: $e')),
//       );
//     }
//   }
// }