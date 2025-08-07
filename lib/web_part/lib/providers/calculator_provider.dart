import 'package:flutter/material.dart';
import '../services/question_service.dart';

class CalculatorProvider extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  Map<String, double> selectedTasks = {};
  int totalPoints = 0;
  double totalHours = 0;

  void updateCalculation() {
    double hours = 0;
    selectedTasks.forEach((key, value) {
      hours += value;
    });

    totalHours = hours;
    totalPoints = 0;
    selectedTasks.forEach((key, value) {
      // the scores map uses lowercase, so normalize key if needed
      final scoreKey = key.replaceAll(' ', '_').toLowerCase();
      final perHourValue = activityScores[scoreKey] ?? 0;
      totalPoints += (value * perHourValue).round();
    });
    notifyListeners();
  }

  void resetCalculation() {
    selectedTasks.clear();
    totalHours = 0;
    totalPoints = 0;
    nameController.clear();
    notifyListeners();
  }



  void selectTask(String taskName, double defaultHours) {
    if (!selectedTasks.containsKey(taskName)) {
      selectedTasks[taskName] = 3; // New: tap adds as 0.5 hours
    } else {
      // double current = selectedTasks[taskName] ?? 0;
      // if (current < 24.0) {
      //   selectedTasks[taskName] = (current + 0.5).clamp(0, 24);
      // }
    }
    updateCalculation();
  }

  void updateTaskHours(String taskName, double hours) {
    if (selectedTasks.containsKey(taskName)) {
      double newValue = hours.clamp(0, 24);
      if (newValue <= 0) {
        selectedTasks.remove(taskName);
      } else {
        selectedTasks[taskName] = newValue;
      }
      updateCalculation();
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
  // double getPointsForTask(String taskId, double hours) {
  //   // Define point values for each task type
  //   final Map<String, double> pointsPerHour = {
  //     'cooking': 50,
  //     'childcare': 50,
  //     'eldercare': 50,
  //     'grocery': 50,
  //     'laundry': 50,
  //     'gardening':50,
  //     'homework_help': 50,
  //     'emotional_support': 50,
  //     'water_collection': 50,
  //     'health_care_support': 50,
  //     'other': 50,
  //   };
  //
  //   return hours * (pointsPerHour[taskId] ?? 50); // Default to 8 points/hour
  // }
}
