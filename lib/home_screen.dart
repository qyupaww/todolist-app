import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'extension.dart';
import 'package:todolist_app/widgets/tile_widget.dart';
import 'constants.dart';
import 'services/bloc/bloc.dart';
import 'widgets/empty_widget.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.black,
      appBar: AppBar(
        backgroundColor: ColorPallete.black,
        scrolledUnderElevation: 0,
        elevation: 0,
        actions: const [
          Icon(Icons.more_horiz_outlined, color: ColorPallete.red),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Today",
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: ColorPallete.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "13 Nov - Thu",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: ColorPallete.white,
              ),
            ),
          ),
          const Divider(thickness: 0.1, color: ColorPallete.grey),
          Expanded(
            child: BlocBuilder<TodoBloc, TodoState>(
              builder: (context, state) {
                final todos = state.todos;
                if (state.status == TodoStatus.empty) {
                  return const TodoEmptyWidget();
                } else if (state.status == TodoStatus.loaded) {
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          TodoTileWidget(
                            key: ValueKey(todos[index].id),
                            todo: todos[index],
                          ),
                          const SizedBox(height: 16),
                          const Divider(
                            thickness: 0.1,
                            color: ColorPallete.grey,
                            indent: 40,
                          ),
                        ],
                      );
                    },
                    itemCount: todos.length,
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.red,
        onPressed: () {
          context.showAddTaskModalDialog();
        },
        tooltip: 'Add Task',
        shape: const CircleBorder(),
        child: const Icon(Icons.add, color: ColorPallete.white),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: ColorPallete.blackLight,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today, color: ColorPallete.white),
            label: "Today",
            activeIcon: Icon(Icons.calendar_today, color: ColorPallete.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox, color: ColorPallete.white),
            label: "Inbox",
            activeIcon: Icon(Icons.inbox, color: ColorPallete.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: ColorPallete.white),
            label: "Search",
            activeIcon: Icon(Icons.search, color: ColorPallete.red),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article, color: ColorPallete.white),
            label: "Browse",
            activeIcon: Icon(Icons.article, color: ColorPallete.red),
          ),
        ],
        selectedItemColor: ColorPallete.red,
        unselectedItemColor: ColorPallete.white,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
