import '../models/question.dart';
import 'package:flutter/material.dart';

// Top-level so it can be imported
final Map<String, int> activityScores = {
  'cooking': 50, // Cooking tasks
  'cleaning': 50, // Cleaning the home
  'childcare': 50, // Taking care of children
  'adult_care': 50, // Caring for elderly family members
  'grocery_shopping': 50, // Grocery shopping
  'laundry': 50, // Laundry tasks
  'gardening': 50, // Gardening work
  'homework_help': 50, // Home maintenance and repairs
  'emotional_support':50, // Managing finances
  'water_collection': 50, // Pet care
  'healthcare_support': 50, // Transportation of family members
  'other': 50, // Volunteer work
  //'planning': 4, // Planning events/activities
};

class QuestionService {
  /// Returns a list of standard questions for the survey
  static List<Question> getQuestions() {
    // Standard yes/no answers
    final List<Answer> yesNoAnswers = [
      Answer(
        key: 'yes',
        value: 'Yes',
        backgroundColor: Colors.green,
        textColor: Colors.white,
      ),
      Answer(
        key: 'no',
        value: 'No',
        backgroundColor: Colors.grey,
        textColor: Colors.white,
      ),
    ];

    // Hour options for slider
    // We're keeping the HourOption structure for compatibility
    // But we'll use a slider that supports 0-90 hours with 0.5 increments
    final List<HourOption> standardHourOptions = [
      HourOption(
        hours: 2,
        label: '2 hours',
        iconPath: 'assets/Image/clock.png',
      ),
      HourOption(
        hours: 4,
        label: '4 hours',
        iconPath: 'assets/Image/clock.png',
      ),
      HourOption(
        hours: 6,
        label: '6 hours',
        iconPath: 'assets/Image/clock.png',
      ),
      HourOption(
        hours: 8,
        label: '8 hours',
        iconPath: 'assets/Image/clock.png',
      ),
      // Additional options are not needed as we're using a slider
    ];

    // Define all questions
    return [
      Question(
        id: '0',
        questionKey: 'cooking',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/cooking.png',
        pointValue: activityScores['cooking'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '1',
        questionKey: 'cleaning',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/cleaning.png',
        pointValue: activityScores['cleaning'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '2',
        questionKey: 'childcare',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/child_care.png',
        pointValue: activityScores['childcare'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '3',
        questionKey: 'eldercare',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/elder_care.png',
        pointValue: activityScores['eldercare'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '4',
        questionKey: 'grocery',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/grocery_shopping.png',
        pointValue: activityScores['grocery_shopping'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '5',
        questionKey: 'laundry',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/laundry.png',
        pointValue: activityScores['laundry'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '6',
        questionKey: 'gardening',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/gardening.png',
        pointValue: activityScores['gardening'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '7',
        questionKey: 'homework_help',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/homework_help.png',
        pointValue: activityScores['homework_help'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '8',
        questionKey: 'emotional_support',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/emotional_support.png',
        pointValue: activityScores['emotional_support'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '9',
        questionKey: 'water_collection',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/water_collection.png',
        pointValue: activityScores['water_collection'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '10',
        questionKey: 'health_care_support',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/helthcare_support.png',
        pointValue: activityScores['healthcare_support'] ?? 0,
        hourOptions: standardHourOptions,
      ),
      Question(
        id: '11',
        questionKey: 'other',
        answers: yesNoAnswers,
        logoPath: 'assets/Image/other.png',
        pointValue: activityScores['other'] ?? 0,
        hourOptions: standardHourOptions,
      ),
    ];
  }
}
