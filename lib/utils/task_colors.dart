import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskColors {
  static final List<Color> taskColors = [
    Colors.orange,
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.red,
  ];

  static Color getColor(int index) {
    return taskColors[index % taskColors.length];
  }
}