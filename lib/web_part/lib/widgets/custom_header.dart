import 'package:flutter/material.dart';
import '../design/themes/colors.dart';
import 'logo_list.dart';

class CustomHeader extends StatelessWidget {
  final String title;
  final bool backButton;
  final bool useLogoList;

  const CustomHeader({
    Key? key,
    required this.title,
    this.backButton = true,
    this.useLogoList = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primary,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [

            if (useLogoList) const LogoList(),
            if (!useLogoList)
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.04,
                  vertical: 16.0,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
