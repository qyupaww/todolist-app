part of 'bloc.dart';

enum TodoStatus { initial, empty, loaded }

class TodoState {
  final TodoStatus status;
  final List<Todo> todos;

  const TodoState({
    this.status = TodoStatus.initial,
    this.todos = const <Todo>[],
  });

  TodoState copyWith({TodoStatus? status, List<Todo>? todos}) {
    return TodoState(status: status ?? this.status, todos: todos ?? this.todos);
  }
}
