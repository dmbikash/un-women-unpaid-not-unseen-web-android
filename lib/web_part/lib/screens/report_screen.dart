// import 'package:flutter/material.dart';
//
// class ReportScreen extends StatelessWidget {
//   const ReportScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Reports'),
//         backgroundColor: const Color(0xFF0099D8),
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Text(
//               'Unpaid Care Work Reports',
//               style: TextStyle(
//                 fontSize: 24,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 24),
//
//             // Placeholder for report content
//             const Card(
//               child: Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   'Report content will be available here. This section will display reports and statistics about unpaid care work across different regions and demographics.',
//                   style: TextStyle(fontSize: 16),
//                 ),
//               ),
//             ),
//
//             const SizedBox(height: 16),
//
//             // Coming soon section
//             Container(
//               padding: const EdgeInsets.all(16),
//               decoration: BoxDecoration(
//                 color: Colors.amber.shade100,
//                 borderRadius: BorderRadius.circular(8),
//                 border: Border.all(color: Colors.amber.shade300),
//               ),
//               child: Row(
//                 children: const [
//                   Icon(Icons.info_outline, color: Colors.amber),
//                   SizedBox(width: 16),
//                   Expanded(
//                     child: Text(
//                         'Reports feature coming soon. Stay tuned for detailed insights on unpaid care work!'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }