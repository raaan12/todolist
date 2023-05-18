import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../models/task_data.dart';

class DetailsScreen extends StatelessWidget {
  final Task task;

  DetailsScreen(this.task);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.teal[400], // Set the desired color here
        title: Text('Task Details'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.asset(
              "images/logo2.png",
              height: 150,
            ),
            Text(
              'Task Details',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 30),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .deleteTask(task);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal), // Set the desired color here
              ),
              child: Text('Delete Task'),
            ),
            ElevatedButton(
              onPressed: () {
                _showEditDialog(context, task);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal), // Set the desired color here
              ),
              child: Text('Edit Task'),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context, Task task) {
    String editedTaskName = task.name;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Task'),
          content: TextField(
            onChanged: (value) {
              editedTaskName = value;
            },
            decoration: InputDecoration(
              hintText: 'Enter the new task name',
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<TaskData>(context, listen: false)
                    .updateTaskName(task, editedTaskName);
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal), // Set the desired color here
              ),
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.teal), // Set the desired color here
              ),
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
