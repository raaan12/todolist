import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_todo/widgets/task_tile.dart';

import '../models/task.dart';
import '../models/task_data.dart';

class TasksList extends StatelessWidget {
  final Function(Task) onTaskClicked; // Add this line

  TasksList({required this.onTaskClicked}); // Add this line

  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemCount: taskData.tasks.length,
          itemBuilder: (context, index) {
            return TaskTile(
              isChecked: taskData.tasks[index].isDone,
              taskTitle: taskData.tasks[index].name,
              checkboxChange: (newValue) {
                taskData.updateTask(taskData.tasks[index]);
              },
              listTileDelete: () {
                taskData.deleteTask(taskData.tasks[index]);
              },
              onTaskClicked: () {
                onTaskClicked(taskData.tasks[index]); // Call the onTaskClicked callback
              },
            );
          },
        );
      },
    );
  }
}
