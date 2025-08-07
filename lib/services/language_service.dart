import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'languages.dart';

// Language service to manage language settings
class LanguageServiceMobile extends ChangeNotifier {
  static const String LANGUAGE_KEY = 'app_language';
  static const String DEFAULT_LANGUAGE = 'en'; // Default to English

  // Singleton pattern implementation
  static final LanguageServiceMobile _instance = LanguageServiceMobile._internal();

  factory LanguageServiceMobile() {
    return _instance;
  }

  LanguageServiceMobile._internal() {
    initLanguage(); // Initialize language on creation
  }

  // Current language
  String _currentLanguage = DEFAULT_LANGUAGE;

  // Getter for the current language
  String get currentLanguage => _currentLanguage;

  // Initialize language from SharedPreferences
  Future<void> initLanguage() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentLanguage = prefs.getString(LANGUAGE_KEY) ?? DEFAULT_LANGUAGE;
      //print('Initializing language service: $_currentLanguage');

      // Update the global language variable in languages.dart
      language = _currentLanguage;

      notifyListeners(); // Notify listeners about the initial language
    } catch (e) {
      //print('Error initializing language: $e');
      _currentLanguage = DEFAULT_LANGUAGE;
      language = DEFAULT_LANGUAGE;
    }
  }

  // Change language and save to SharedPreferences
  Future<void> changeLanguage(String languageCode) async {
    if (languageCode != 'bn' && languageCode != 'en') {
      return; // Only allow 'bn' or 'en'
    }

    if (_currentLanguage != languageCode) {
      try {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(LANGUAGE_KEY, languageCode);
        _currentLanguage = languageCode;

        // Update the global language variable in languages.dart
        language = languageCode;

        notifyListeners(); // Notify listeners about the language change
      } catch (e) {
        //print('Error changing language: $e');
      }
    }
  }

  // Toggle between Bengali and English
  Future<void> toggleLanguage() async {
    final newLanguage = (_currentLanguage == 'en') ? 'bn' : 'en';
    //print('Toggling language from $_currentLanguage to $newLanguage');

    // First update the in-memory variables to immediately reflect changes
    _currentLanguage = newLanguage;
    language = newLanguage;

    // Notify listeners before saving to ensure UI updates immediately
    notifyListeners();

    try {
      // Then save to SharedPreferences in background
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(LANGUAGE_KEY, newLanguage);
    } catch (e) {
      //print('Error saving language preference: $e');
    }
  }

  // Check if language is English
  bool isEnglish() {
    return _currentLanguage == 'en';
  }

  // Get the current language name for display
  String get currentLanguageName {
    switch (_currentLanguage) {
      case 'bn':
        return 'বাংলা';
      case 'en':
      default:
        return 'English';
    }
  }

  // Get the opposite language name for display in the switch button
  String get oppositeLanguageName {
    switch (_currentLanguage) {
      case 'bn':
        return 'English';
      case 'en':
      default:
        return 'বাংলা';
    }
  }

  // Convert numbers to Bengali digits when language is Bengali
  String convertNumberToBengali(String number) {
    if (_currentLanguage != 'bn') return number;

    final Map<String, String> bengaliNumerals = {
      '0': '০',
      '1': '১',
      '2': '২',
      '3': '৩',
      '4': '৪',
      '5': '৫',
      '6': '৬',
      '7': '৭',
      '8': '৮',
      '9': '৯',
      '.': '.',
    };

    String result = '';
    for (int i = 0; i < number.length; i++) {
      result += bengaliNumerals[number[i]] ?? number[i];
    }
    return result;
  }
}

// Global language service instance
final languageService = LanguageServiceMobile();
