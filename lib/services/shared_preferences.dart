import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../data/todo.dart';

class TodoSharedPreferences {
  static const todoListKey = "todo_list_key";

  TodoSharedPreferences() {
    _initSharedPreferences();
  }

  SharedPreferences? _sharedPreferences;

  Future<void> _initSharedPreferences() async {
    if (_sharedPreferences != null) return;
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future<List<Todo>> getAllTodos() async {
    await _initSharedPreferences();
    if (_sharedPreferences != null) {
      final todoJson = _sharedPreferences!.getString(todoListKey);

      if (todoJson != null) {
        List<Todo> todoLists = _convertJsonToTodoLists(todoJson);
        return todoLists;
      } else {
        return [];
      }
    }
    return [];
  }

  Future<void> saveTodo(Todo todo) async {
    await _initSharedPreferences();

    final todoJson = _sharedPreferences!.getString(todoListKey);
    if (todoJson != null) {
      List<Todo> todos = _convertJsonToTodoLists(todoJson);
      final todoIndex = todos.indexWhere((t) => t.id == todo.id);
      if (todoIndex >= 0) {
        todos[todoIndex] = todo;
      } else {
        todos.add(todo);
      }

      if (_sharedPreferences != null) {
        _sharedPreferences!.setString(todoListKey, jsonEncode(todos));
      }
    } else {
      List<Todo> todos = [todo];
      if (_sharedPreferences != null) {
        _sharedPreferences!.setString(todoListKey, jsonEncode(todos));
      }
    }
  }

  Future<void> deleteTodoById(String id) async {
    await _initSharedPreferences();

    final todoJson = _sharedPreferences!.getString(todoListKey);

    if (todoJson != null) {
      List<Todo> todos = _convertJsonToTodoLists(todoJson);
      final todoIndex = todos.indexWhere((t) => t.id == id);
      if (todoIndex == -1) {
        return;
      } else {
        todos.removeAt(todoIndex);
        if (_sharedPreferences != null) {
          _sharedPreferences!.setString(todoListKey, jsonEncode(todos));
        }
      }
    }
  }

  List<Todo> _convertJsonToTodoLists(String todoJson) {
    return (json.decode(todoJson) as List<dynamic>)
        .map((todoJson) => Todo.fromJson(todoJson as Map<String, dynamic>))
        .toList();
  }
}
