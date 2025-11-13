import 'package:flutter/material.dart';

import 'home_screen.dart';

void main() {
  runApp(const TodolistApp());
}

class TodolistApp extends StatelessWidget {
  const TodolistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Todo List App', home: const TodoHomeScreen());
  }
}
