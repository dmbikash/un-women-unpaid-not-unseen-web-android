import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unwomen_unpaid_not_unseen/web_part/lib/services/language_service.dart';
import '../../controller/routes.dart';
import '../../design/animations/no_animation_page_transition.dart';
import '../../design/animations/no_splash.dart' as custom;
import '../../design/themes/theme.dart';
import '../../services/language_service.dart';
import 'screens/calculator_screen.dart';
import 'screens/contact_screen.dart';
import 'screens/campaign_info_screen.dart';
import 'providers/calculator_provider.dart';
import 'constants/app_theme.dart';
import 'screens/result_page.dart';
import 'screens/share_result_page.dart';



class WebApp extends StatelessWidget {
  const WebApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Make status bar transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );

    // Create theme with disabled animations
    final noAnimationTheme = lightTheme.copyWith(
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: NoAnimationTransitionBuilder(),
          TargetPlatform.iOS: NoAnimationTransitionBuilder(),
        },
      ),
      splashFactory: custom.NoSplash.splashFactory,
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Unpaid Work Calculator',

      // Use animation-free theme
      theme: noAnimationTheme,
      darkTheme: noAnimationTheme,
      themeMode: ThemeMode.light,
      // Add global app styling
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            platformBrightness: Brightness.light, textScaler: TextScaler.linear(1.0),
          ),
          child: child!,
        );
      },
      initialRoute: WebRoutes.webHome,
      routes: WebRoutes.routes,
    );
  }
}