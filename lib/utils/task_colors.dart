import 'package:flutter/material.dart';

class TaskColors {
  static final List<Color> taskColors = [
    Colors.orange,
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
  ];

  static Color getColor(int index) {
    return taskColors[index % taskColors.length];
  }
}