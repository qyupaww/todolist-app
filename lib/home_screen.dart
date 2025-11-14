import 'package:flutter/material.dart';
import 'package:todolist_app/widgets/tile_widget.dart';
import 'constants.dart';
import 'data/todo.dart';

class TodoHomeScreen extends StatefulWidget {
  const TodoHomeScreen({super.key});

  @override
  State<TodoHomeScreen> createState() => _TodoHomeScreenState();
}

class _TodoHomeScreenState extends State<TodoHomeScreen> {
  List<Todo> _todos = [];
  int _selectedIndex = 0;

  String? _title;
  String? _description;

  @override
  void initState() {
    super.initState();
    _todos = [
      Todo(title: "Task 1", description: "Belajar Dart"),
      Todo(title: "Task 2", description: "Belajar Flutter"),
    ];
  }

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
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    TodoTileWidget(todo: _todos[index]),
                    const SizedBox(height: 16),
                    const Divider(
                      thickness: 0.1,
                      color: ColorPallete.grey,
                      indent: 40,
                    ),
                  ],
                );
              },
              itemCount: _todos.length,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPallete.red,
        onPressed: () {
          _showAddTaskModalBottomSheet(context);
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

  void _addTodo() {
    if (_title != null && _description != null) {
      var todo = Todo(title: _title!, description: _description!);

      setState(() {
        _todos.add(todo);
      });
    }
  }

  void _showAddTaskModalBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: ColorPallete.black,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            top: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  _title = value;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintText: 'Task Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                style: TextStyle(
                  color: ColorPallete.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                cursorColor: ColorPallete.red,
                autofocus: true,
              ),
              TextField(
                onChanged: (value) {
                  _description = value;
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  hintText: 'Description Title',
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                    color: ColorPallete.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.none,
                  ),
                ),
                style: TextStyle(
                  color: ColorPallete.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.none,
                  decorationThickness: 0,
                ),
                cursorColor: ColorPallete.red,
              ),
              const Divider(thickness: 0.1, color: ColorPallete.grey),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.inbox, color: ColorPallete.white),
                    IconButton(
                      onPressed: () {
                        _addTodo();
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_circle_right,
                        color: ColorPallete.red,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
