import 'package:flutter/material.dart';

import '../design/themes/colors.dart';


class LogoList extends StatelessWidget {
  final int? preset;
  final Color? backgroundColor;

  const LogoList({
    super.key,
    this.preset,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    //final Color bgColor = backgroundColor ?? (preset == 1 ? ThemeColor.primary : const Color(0xFF47898B));
   // final Color bgColor = ThemeColor.primary;
    return ClipPath(
      child: Container(
        padding: EdgeInsets.all(10),
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 5,
              spreadRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width * 0.92,
              // Match card width
              height: MediaQuery.of(context).size.height * 0.07,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    spreadRadius: 1,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                "assets/logo/un_woman.png",
                height: 50,
                width: 45,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
