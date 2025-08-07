import 'package:flutter/material.dart';

class Question {
  final String id;
  final String questionKey;
  final String logoPath;
  final List<Answer> answers;
  final int pointValue;
  final List<HourOption>? hourOptions;

  Question({
    required this.id,
    required this.questionKey,
    required this.logoPath,
    required this.answers,
    this.pointValue = 0,
    this.hourOptions,
  });
}

class Answer {
  final String key;
  final String value;
  final Color? backgroundColor;
  final Color? textColor;

  Answer({
    required this.key,
    required this.value,
    this.backgroundColor,
    this.textColor,
  });
}

class HourOption {
  final int hours;
  final String label;
  final String iconPath;

  HourOption({
    required this.hours,
    required this.label,
    required this.iconPath,
  });
}
