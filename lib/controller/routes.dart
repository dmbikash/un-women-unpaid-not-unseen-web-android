import 'package:flutter/material.dart';
import '../backup/temp.dart';
import '../views/home_page.dart';
import '../views/calculator_page.dart';
import '../views/result_page.dart';
import '../views/questions_screen.dart';
import '../views/landing_page.dart';
import '../views/splash_screen.dart';
import '../views/share_result_page.dart';
import '../web_part/lib/screens/calculator_screen.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String calculator = '/calculator';
  static const String result = '/result';
  static const String temp = '/temp';
  static const String questions = '/questions';
  static const String landing = '/landing';
  static const String shareResult = '/share_result';

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomePage(),
    calculator: (context) => const CalculatorPage(),
    result: (context) =>  ResultPage(),
    temp: (context) => const TempPage(),
    questions: (context) => const QuestionsScreen(),
    landing: (context) => const LandingPage(),
    shareResult: (context) =>  ShareResultPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // For routes that need arguments
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case calculator:
        return MaterialPageRoute(builder: (context) => const CalculatorPage());
      case result:
        // Handle arguments if needed
        final args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) =>  ResultPage(), settings: settings);
      case temp:
        return MaterialPageRoute(builder: (context) => const TempPage());
      case questions:
        return MaterialPageRoute(builder: (context) => const QuestionsScreen());
      case landing:
        return MaterialPageRoute(builder: (context) => const LandingPage());
      case shareResult:
        return MaterialPageRoute(
            builder: (context) =>  ShareResultPage(), settings: settings);
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}


class WebRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String calculator = '/calculator';
  static const String result = '/result';
  static const String temp = '/temp';
  static const String questions = '/questions';
  static const String landing = '/landing';
  static const String shareResult = '/share_result';

  static Map<String, Widget Function(BuildContext)> routes = {
    //splash: (context) => const SplashScreen(),
    home: (context) => const CalculatorScreen(),

    // calculator: (context) => const CalculatorPage(),
    // result: (context) =>  ResultPage(),
    // temp: (context) => const TempPage(),
    // questions: (context) => const QuestionsScreen(),
    // landing: (context) => const LandingPage(),
    // shareResult: (context) =>  ShareResultPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // For routes that need arguments
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (context) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (context) => const HomePage());
      case calculator:
        return MaterialPageRoute(builder: (context) => const CalculatorPage());
      case result:
      // Handle arguments if needed
        final args = settings.arguments;
        return MaterialPageRoute(
            builder: (context) =>  ResultPage(), settings: settings);
      case temp:
        return MaterialPageRoute(builder: (context) => const TempPage());
      case questions:
        return MaterialPageRoute(builder: (context) => const QuestionsScreen());
      case landing:
        return MaterialPageRoute(builder: (context) => const LandingPage());
      case shareResult:
        return MaterialPageRoute(
            builder: (context) =>  ShareResultPage(), settings: settings);
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}