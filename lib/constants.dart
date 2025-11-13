import 'package:flutter/material.dart';
import 'data/todo.dart';

class ColorPallete {
  static const black = Color(0xFF242323);
  static const blackLight = Color(0xFF393838);
  static const red = Color(0xFFCD3608);
  static const grey = Color(0xFFC2C2C2);
  static const white = Color(0xFFFFFFEF);
}

class DummyData {
  static final taskList = [
    Todo(title: "Task 1", description: "Belajar Dart"),
    Todo(title: "Task 2", description: "Belajar Flutter"),
  ];
}
