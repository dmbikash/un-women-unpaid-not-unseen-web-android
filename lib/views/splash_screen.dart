import 'package:flutter/material.dart';
import 'dart:async';
import '../controller/routes.dart';
import '../design/themes/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate after a short delay without animations
    Timer(const Duration(milliseconds: 1000), () {
      Navigator.pushReplacementNamed(context, WebRoutes.landing);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Container(
        color: AppColors.primary, // Simple solid color background
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Simple container without animations
              Container(
                padding: EdgeInsets.all(screenWidth * 0.05),
                margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(screenWidth * 0.04),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.07),
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // UN Women logo
                    Image.asset(
                      'assets/logo/un_woman.png',
                      height: screenHeight * 0.08,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: screenHeight * 0.03),

                    // Unpaid work logo
                    Image.asset(
                      'assets/logo/unpaid_not_unseen.png',
                      height: screenHeight * 0.12,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
