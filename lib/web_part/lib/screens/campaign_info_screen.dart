// import 'package:flutter/material.dart';
//
// import '../constants/text_styles.dart';
//
// // ... existing code ...
// class CampaignInfoScreen extends StatelessWidget {
//   const CampaignInfoScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final mq = MediaQuery.of(context);
//     final width = mq.size.width;
//     final height = mq.size.height;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF0099D8),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         elevation: 0,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Campaign header with logo
//             Container(
//               width: double.infinity,
//               color: const Color(0xFF0099D8),
//               padding: EdgeInsets.symmetric(
//                 vertical: (height * 0.055).clamp(24.0, 70.0),
//                 horizontal: (width * 0.04).clamp(12.0, 40.0),
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(
//                     'assets/logo/unpaid_not_unseen.png',
//                     height: (height * 0.13).clamp(70.0, 200.0),
//                   ),
//                   SizedBox(height: (height * 0.03).clamp(14.0, 36.0)),
//                   Text(
//                     'Recognizing and valuing unpaid care work',
//                     style: AppTextStyles.h2(context),
//                     textAlign: TextAlign.center,
//                   ),
//                 ],
//               ),
//             ),
//
//             // Campaign info content
//             Padding(
//               padding: EdgeInsets.all((width * 0.04).clamp(14.0, 40.0)),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'About the Campaign',
//                     style: AppTextStyles.h1(context),
//                   ),
//                   SizedBox(height: (height * 0.018).clamp(8.0, 30.0)),
//                   Text(
//                     'The "Unpaid Not Unseen" campaign highlights the significant but often invisible contribution of unpaid care work to our society and economy. This work, predominantly performed by women, includes domestic chores, childcare, elder care, and supporting family members and communities.',
//                     style: AppTextStyles.normal(context),
//                   ),
//                   SizedBox(height: (height * 0.012).clamp(5.0, 18.0)),
//                   Text(
//                     'Through this calculator tool, we aim to make this work visible by assigning points that represent the value of time spent on various care tasks.',
//                     style: AppTextStyles.normal(context),
//                   ),
//                   SizedBox(height: (height * 0.035).clamp(18.0, 54.0)),
//
//                   // Campaign goals
//                   Text(
//                     'Our Mission',
//                     style: AppTextStyles.h2(context),
//                   ),
//                   SizedBox(height: (height * 0.018).clamp(8.0, 30.0)),
//                   _buildGoalItem(context,
//                       'Raise awareness about the economic and social value of unpaid care work'),
//                   _buildGoalItem(context,
//                       'Advocate for policies that recognize, reduce, and redistribute care work'),
//                   _buildGoalItem(context,
//                       'Promote gender equality in the distribution of unpaid work'),
//                   _buildGoalItem(context,
//                       'Develop tools to measure and value care work in national accounting'),
//
//                   SizedBox(height: (height * 0.035).clamp(18.0, 54.0)),
//
//                   // Campaign stats
//                   Card(
//                     elevation: 4,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.all((width * 0.027).clamp(8.0, 28.0)),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               const Icon(Icons.lightbulb, color: Colors.amber,
//                                   size: 28),
//                               SizedBox(width: (width * 0.025).clamp(7.0, 25.0)),
//                               Text(
//                                 'Did You Know?',
//                                 style: AppTextStyles.h2(context),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: (height * 0.018).clamp(8.0, 30.0)),
//                           _buildStatItem(context,
//                               'Women globally spend 2-10 times more time on unpaid care work than men'),
//                           _buildStatItem(context,
//                               'If valued at minimum wage, unpaid care work would represent 9-11% of global GDP'),
//                           _buildStatItem(context,
//                               'Recognizing unpaid work is key to achieving multiple Sustainable Development Goals'),
//                           _buildStatItem(context,
//                               'The COVID-19 pandemic has significantly increased the burden of unpaid care work'),
//                         ],
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: (height * 0.045).clamp(20.0, 60.0)),
//
//                   // Partners section
//                   Text(
//                     'Our Partners',
//                     style: AppTextStyles.h2(context),
//                   ),
//                   SizedBox(height: (height * 0.018).clamp(8.0, 30.0)),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Image.asset('assets/logo/un_woman.png',
//                           height: (height * 0.09).clamp(44.0, 120.0)),
//                       // Add more partner logos if needed
//                     ],
//                   ),
//
//                   SizedBox(height: (height * 0.045).clamp(20.0, 60.0)),
//
//                   // Get involved section
//                   Container(
//                     padding: EdgeInsets.all((width * 0.055).clamp(14.0, 32.0)),
//                     decoration: BoxDecoration(
//                       color: Colors.blue.shade50,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                           color: const Color(0xFF0099D8).withOpacity(0.3)),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Join Our Campaign',
//                           style: AppTextStyles.h2(context),
//                         ),
//                         SizedBox(height: (height * 0.018).clamp(8.0, 30.0)),
//                         Text(
//                           'Help us make unpaid care work visible and valued! Share your story, spread awareness, and advocate for change in your community.',
//                           style: AppTextStyles.normal(context),
//                         ),
//                         SizedBox(height: (height * 0.032).clamp(12.0, 44.0)),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             _buildActionButton(context, 'Share Your Story',
//                                 Icons.chat_bubble_outline),
//                             _buildActionButton(context, 'Spread the Word',
//                                 Icons.share),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                   SizedBox(height: (height * 0.045).clamp(20.0, 60.0)),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildGoalItem(BuildContext context, String text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: (MediaQuery
//             .of(context)
//             .size
//             .height * 0.01).clamp(4.0, 14.0),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(
//             Icons.check_circle,
//             color: Color(0xFF0099D8),
//             size: 22,
//           ),
//           SizedBox(width: (MediaQuery
//               .of(context)
//               .size
//               .width * 0.03).clamp(8.0, 20.0)),
//           Expanded(
//             child: Text(
//               text,
//               style: AppTextStyles.normal(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildStatItem(BuildContext context, String text) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: (MediaQuery
//             .of(context)
//             .size
//             .height * 0.01).clamp(4.0, 14.0),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const Icon(
//             Icons.star,
//             color: Colors.amber,
//             size: 20,
//           ),
//           SizedBox(width: (MediaQuery
//               .of(context)
//               .size
//               .width * 0.03).clamp(8.0, 20.0)),
//           Expanded(
//             child: Text(
//               text,
//               style: AppTextStyles.normal(context),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildActionButton(BuildContext context, String text, IconData icon) {
//     return ElevatedButton.icon(
//       onPressed: () {},
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF0099D8),
//         padding: EdgeInsets.symmetric(
//           horizontal: (MediaQuery
//               .of(context)
//               .size
//               .width * 0.035).clamp(10.0, 28.0),
//           vertical: (MediaQuery
//               .of(context)
//               .size
//               .height * 0.015).clamp(6.0, 20.0),
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//       ),
//       icon: Icon(icon, color: Colors.white),
//       label: Text(
//         text,
//         style: AppTextStyles.buttonText(context),
//       ),
//     );
//   }
// }