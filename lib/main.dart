import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';
import 'services/model.dart';

void main() {
  runApp(const TodolistApp());
}

class TodolistApp extends StatelessWidget {
  const TodolistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      home: ChangeNotifierProvider(
        create: (_) => TodoModel(),
        child: const TodoHomeScreen(),
      ),
    );
  }
}
