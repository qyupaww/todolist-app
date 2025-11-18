import 'package:flutter/material.dart';

import '../constants.dart';

class TodoEmptyWidget extends StatelessWidget {
  const TodoEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      width: double.infinity,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.edit_note, size: 100, color: ColorPallete.red),
          SizedBox(height: 20),
          Text(
            "You're all done with all the tasks",
            style: TextStyle(
              color: ColorPallete.grey,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Enjoy your day",
            style: TextStyle(
              color: ColorPallete.grey,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
