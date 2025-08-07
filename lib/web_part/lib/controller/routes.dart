import 'package:flutter/material.dart';
import '../screens/calculator_screen.dart';
import '../screens/report_screen.dart';
import '../screens/campaign_info_screen.dart';
import '../screens/contact_screen.dart';
import '../screens/share_result_page.dart';
import '../screens/share_result_screen.dart';
import '../backup/temp.dart';
import '../views/unpaid_work_calculator.dart';
import '../screens/result_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/';
  static const String calculator = '/calculator';
  static const String report = '/report';
  static const String temp = '/temp';
  static const String campaign = '/campaign';
  static const String contact = '/contact';
  static const String shareResult = '/share_result';
  static const String result = '/result';

  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (context) =>
    const Scaffold(body: Center(child: Text('Splash Screen'))),
    home: (context) => const UnpaidWorkCalculator(),
    calculator: (context) => const CalculatorScreen(),
    report: (context) => const ReportScreen(),
    temp: (context) => const TempPage(),
    campaign: (context) => const CampaignInfoScreen(),
    //contact: (context) => const ContactScreen(),
    shareResult: (context) =>
    const ShareResultPage(
      name: '',
      totalHours: 0.0,
      totalValue: 0.0,
      selectedTasks: <String, double>{},
    ),
    result: (context) => const ResultPage(),
  };

  static Route<dynamic> generateRoute(RouteSettings settings) {
    // For routes that need arguments
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (context) =>
          const Scaffold(
            body: Center(child: Text('Splash Screen')),
          ),
        );
      case home:
        return MaterialPageRoute(
            builder: (context) => const UnpaidWorkCalculator());
      case calculator:
        return MaterialPageRoute(
            builder: (context) => const CalculatorScreen());
      case report:
        return MaterialPageRoute(builder: (context) => const ReportScreen());
      case temp:
        return MaterialPageRoute(builder: (context) => const TempPage());
      case campaign:
        return MaterialPageRoute(
            builder: (context) => const CampaignInfoScreen());
      //case contact:
        //return MaterialPageRoute(builder: (context) => const ContactScreen());
      case shareResult:
      // For ShareResultScreen, we need to handle arguments
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null) {
          return MaterialPageRoute(
            builder: (context) =>
                ShareResultPage(
                  name: args['name'] ?? '',
                  totalHours: args['totalHours'] ?? 0.0,
                  totalValue: args['totalValue'] ?? 0.0,
                  selectedTasks: args['selectedTasks'] ?? <String, double>{},
                ),
          );
        }
        // Default ShareResult with empty values
        return MaterialPageRoute(
          builder: (context) =>
          const ShareResultPage(
            name: '',
            totalHours: 0.0,
            totalValue: 0.0,
            selectedTasks: <String, double>{},
          ),
        );
      case result:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args != null) {
          return MaterialPageRoute(
            builder: (context) =>
                ResultPage(
                  name: args['name'] ?? '',
                  totalHours: args['totalHours'] ?? 0.0,
                  totalValue: args['totalValue'] ?? 0.0,
                  selectedTasks: args['selectedTasks'] ?? <String, double>{},
                ),
          );
        }
        // Default ResultPage with empty values
        return MaterialPageRoute(
          builder: (context) =>
          const ResultPage(
            name: '',
            totalHours: 0.0,
            totalValue: 0.0,
            selectedTasks: <String, double>{},
          ),
        );
      default:
        return MaterialPageRoute(
          builder: (context) =>
              Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
