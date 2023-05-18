import 'package:flutter/material.dart';
class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final void Function(bool?) checkboxChange;
  final void Function() listTileDelete;
  final Function() onTaskClicked; // Add this line


  TaskTile(
      {required this.isChecked,
        required this.taskTitle,
        required this.checkboxChange,
        required this.listTileDelete,
        required this.onTaskClicked, // Add this line
      });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        taskTitle,
        style: TextStyle(
            decoration: isChecked ? TextDecoration.lineThrough : null),
      ),
      trailing: Checkbox(
        activeColor: Colors.teal[400],
        value: isChecked,
        onChanged: checkboxChange,
      ),
      onLongPress: listTileDelete,
      onTap: onTaskClicked, // Call the onTaskClicked callback

    );
  }
}