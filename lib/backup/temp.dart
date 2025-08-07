import 'package:flutter/material.dart';

import '../design/themes/colors.dart';
import '../design/text/textStyles.dart';

class TempPage extends StatelessWidget {
  const TempPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          'Question Card Example',
          style: ThemeTextStyles.heading.copyWith(color: AppColors.white),
        ),
        backgroundColor: AppColors.primary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [


            const SizedBox(height: 20),



            const SizedBox(height: 20),


          ],
        ),
      ),
    );
  }
}
