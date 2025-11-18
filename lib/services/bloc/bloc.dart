import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/todo.dart';
import '../shared_preferences.dart';

part 'event.dart';
part 'state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoSharedPreferences todoSharedPreferences;

  TodoBloc(this.todoSharedPreferences) : super(const TodoState()) {
    on<TodoInitEvent>(_onInitTodo);
    on<TodoAddTaskEvent>(_onAddTask);
    on<TodoEditTaskEvent>(_onEditTask);
    on<TodoRemoveTaskEvent>(_onRemoveTask);
  }

  void _onInitTodo(TodoInitEvent event, Emitter<TodoState> emit) async {
    final todos = await todoSharedPreferences.getAllTodos();

    if (todos.isNotEmpty) {
      emit(
        TodoState(
          status: TodoStatus.loaded,
          todos: List.of(state.todos)..addAll(todos),
        ),
      );
    } else {
      emit(const TodoState(status: TodoStatus.empty));
    }
  }

  void _onAddTask(TodoAddTaskEvent event, Emitter<TodoState> emit) async {
    final todo = Todo(title: event.title, description: event.description);

    emit(
      state.copyWith(
        status: TodoStatus.loaded,
        todos: List.of(state.todos)..add(todo),
      ),
    );

    await todoSharedPreferences.saveTodo(todo);
  }

  void _onEditTask(TodoEditTaskEvent event, Emitter<TodoState> emit) async {
    final selectedIndex = state.todos.indexWhere((todo) => todo.id == event.id);
    final selectedTodo = state.todos[selectedIndex];

    final todo = selectedTodo.copyWith(
      title: event.title,
      description: event.description,
    );

    state.todos[selectedIndex] = todo;

    emit(
      state.copyWith(status: TodoStatus.loaded, todos: List.of(state.todos)),
    );

    await todoSharedPreferences.saveTodo(todo);
  }

  void _onRemoveTask(TodoRemoveTaskEvent event, Emitter<TodoState> emit) async {
    await todoSharedPreferences.deleteTodoById(event.id);

    state.todos.removeWhere((todo) => todo.id == event.id);

    if (state.todos.isNotEmpty) {
      emit(
        state.copyWith(status: TodoStatus.loaded, todos: List.of(state.todos)),
      );
    } else {
      emit(const TodoState(status: TodoStatus.empty));
    }
  }
}
