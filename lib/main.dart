import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:unwomen_unpaid_not_unseen/providers/question_provider_principal.dart';
import 'package:unwomen_unpaid_not_unseen/web_part/lib/providers/calculator_provider.dart';
import 'package:unwomen_unpaid_not_unseen/web_part/lib/web_main.dart';
import 'package:unwomen_unpaid_not_unseen/web_part/test.dart';
import 'design/themes/theme.dart';
import 'providers/theme_provider.dart';
import 'providers/question_provider_old.dart';
import 'controller/routes.dart';
import 'services/language_service.dart';
import 'design/animations/no_animation_page_transition.dart';
import 'design/animations/no_splash.dart' as custom;


void main() async {
  // Ensure Flutter is initialized before using platform channels (for SharedPreferences)
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize language service
  await languageService.initLanguage();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuestionProvider_old_app()),
        ChangeNotifierProvider.value(value: languageService),
        ///
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => LanguageServiceMobile()),
        ChangeNotifierProvider(create: (_) => QuestionProviderPrincipal()),
      ],
      child: const WebApp(),
    ),
  );
}

class AppSelector extends StatelessWidget {
  const AppSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // ✅ Check if it's web
        if (kIsWeb) {
          // ✅ Check screen width
          if (constraints.maxWidth > 700) {
            // Show Web App
            return  WebApp(); // <-- Your web version
          } else {
            // Show Mobile App even on web
            return const AndroidApp();
          }
        } else {
          // Not web → Always show mobile app
          return const AndroidApp();
        }
      },
    );
  }
}

class AndroidApp extends StatelessWidget {
  const AndroidApp({super.key});

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
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.routes,
    );
  }
}
