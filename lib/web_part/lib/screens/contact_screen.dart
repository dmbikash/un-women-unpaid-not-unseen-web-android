// import 'package:flutter/material.dart';
// import '../constants/text_styles.dart';
//
// class ContactScreen extends StatefulWidget {
//   const ContactScreen({super.key});
//
//   @override
//   State<ContactScreen> createState() => _ContactScreenState();
// }
//
// class _ContactScreenState extends State<ContactScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _nameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _messageController = TextEditingController();
//   String _selectedTopic = 'General Inquiry';
//
//   final List<String> _topics = [
//     'General Inquiry',
//     'Technical Support',
//     'Feedback',
//     'Partnerships',
//     'Media Inquiry',
//   ];
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _emailController.dispose();
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       // In a real app, this would send the form data
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Thank you! Your message has been sent.', style: AppTextStyles.normal(context))),
//       );
//
//       // Clear form
//       _nameController.clear();
//       _emailController.clear();
//       _messageController.clear();
//       setState(() {
//         _selectedTopic = 'General Inquiry';
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Contact Us', style: AppTextStyles.h1(context)),
//         backgroundColor: const Color(0xFF0099D8),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(24.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Get in Touch',
//                 style: AppTextStyles.h1(context),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 'We\'d love to hear from you. Please fill out the form below and we\'ll get back to you as soon as possible.',
//                 style: AppTextStyles.normal(context),
//               ),
//               const SizedBox(height: 32),
//
//               // Contact Form
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     TextFormField(
//                       controller: _nameController,
//                       decoration: const InputDecoration(
//                         labelText: 'Full Name',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.person),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//                     TextFormField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                         labelText: 'Email Address',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.email),
//                       ),
//                       keyboardType: TextInputType.emailAddress,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter your email';
//                         }
//                         if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                             .hasMatch(value)) {
//                           return 'Please enter a valid email address';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Topic dropdown
//                     DropdownButtonFormField<String>(
//                       decoration: const InputDecoration(
//                         labelText: 'Topic',
//                         border: OutlineInputBorder(),
//                         prefixIcon: Icon(Icons.topic),
//                       ),
//                       value: _selectedTopic,
//                       items: _topics.map((topic) {
//                         return DropdownMenuItem<String>(
//                           value: topic,
//                           child: Text(topic, style: AppTextStyles.normal(context)),
//                         );
//                       }).toList(),
//                       onChanged: (value) {
//                         setState(() {
//                           _selectedTopic = value!;
//                         });
//                       },
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Message text area
//                     TextFormField(
//                       controller: _messageController,
//                       decoration: const InputDecoration(
//                         labelText: 'Message',
//                         border: OutlineInputBorder(),
//                         alignLabelWithHint: true,
//                         hintText: 'How can we help you?',
//                       ),
//                       maxLines: 5,
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter a message';
//                         }
//                         if (value.length < 10) {
//                           return 'Message should be at least 10 characters long';
//                         }
//                         return null;
//                       },
//                     ),
//                     const SizedBox(height: 32),
//
//                     // Submit button
//                     SizedBox(
//                       width: double.infinity,
//                       height: 50,
//                       child: ElevatedButton(
//                         onPressed: _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF0099D8),
//                           foregroundColor: Colors.white,
//                         ),
//                         child: Text(
//                           'Send Message',
//                           style: AppTextStyles.buttonText(context),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 48),
//
//               // Contact information
//               Text(
//                 'Other Ways to Contact Us',
//                 style: AppTextStyles.h2(context),
//               ),
//               const SizedBox(height: 16),
//
//               // Contact info cards
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildContactInfoCard(
//                       Icons.email_outlined,
//                       'Email',
//                       'info@unpaidnotunseen.org',
//                     ),
//                   ),
//                   const SizedBox(width: 16),
//                   Expanded(
//                     child: _buildContactInfoCard(
//                       Icons.phone_outlined,
//                       'Phone',
//                       '+880123456789',
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//               _buildContactInfoCard(
//                 Icons.location_on_outlined,
//                 'Address',
//                 'House: 74 (lift 5 Road: 21, Block: B, ঢাকা 1213,Banani',
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildContactInfoCard(IconData icon, String title, String content) {
//     return Card(
//       elevation: 3,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Icon(
//               icon,
//               size: 24,
//               color: const Color(0xFF0099D8),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               title,
//               style: AppTextStyles.h3(context),
//             ),
//             const SizedBox(height: 4),
//             Text(
//               content,
//               style: AppTextStyles.normal(context),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }