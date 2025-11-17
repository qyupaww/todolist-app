part of 'bloc.dart';

abstract class TodoEvent {}

class TodoInitEvent extends TodoEvent {}

class TodoAddTaskEvent extends TodoEvent {
  final String title;
  final String description;

  TodoAddTaskEvent({required this.title, required this.description});
}

class TodoEditTaskEvent extends TodoEvent {
  final String id;
  final String title;
  final String description;

  TodoEditTaskEvent({
    required this.id,
    required this.title,
    required this.description,
  });
}

class TodoRemoveTaskEvent extends TodoEvent {
  final String id;

  TodoRemoveTaskEvent({required this.id});
}
