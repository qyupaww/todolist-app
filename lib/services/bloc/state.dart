part of 'bloc.dart';

enum TodoStatus { initial, loaded }

class TodoState {
  final TodoStatus status;
  final List<Todo> todos;

  const TodoState({this.status = TodoStatus.initial, this.todos = const []});
}
