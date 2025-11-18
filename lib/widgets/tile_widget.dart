import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist_app/extension.dart';
import 'package:todolist_app/services/bloc/bloc.dart';
import '../constants.dart';
import '../data/todo.dart';

class TodoTileWidget extends StatefulWidget {
  final Todo todo;
  const TodoTileWidget({required this.todo, super.key});

  @override
  State<TodoTileWidget> createState() => _TodoTileWidgetState();
}

class _TodoTileWidgetState extends State<TodoTileWidget> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();

    _isChecked = widget.todo.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: Transform.scale(
            scale: 1.2,
            child: Checkbox(
              activeColor: ColorPallete.red,
              value: _isChecked,
              onChanged: (value) async {
                if (value != null) {
                  setState(() {
                    _isChecked = value;
                  });
                  if (value == true) {
                    await Future.delayed(const Duration(milliseconds: 800));
                    if (mounted)
                      context.read<TodoBloc>().add(
                        TodoRemoveTaskEvent(widget.todo.id),
                      );
                  }
                }
              },
              shape: const CircleBorder(),
              side: const BorderSide(width: 0.5, color: ColorPallete.grey),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () {
            context.showAddTaskModalDialog(todo: widget.todo);
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.todo.title,
                style: TextStyle(
                  color: ColorPallete.white,
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.todo.description,
                style: TextStyle(
                  color: ColorPallete.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
