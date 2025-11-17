import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';
import 'services/bloc/bloc.dart';
import 'services/shared_preferences.dart';

void main() {
  runApp(const TodolistApp());
}

class TodolistApp extends StatelessWidget {
  const TodolistApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      home: BlocProvider<TodoBloc>(
        create: (_) => TodoBloc(TodoSharedPreferences())..add(TodoInitEvent()),
        child: const TodoHomeScreen(),
      ),
    );
  }
}
