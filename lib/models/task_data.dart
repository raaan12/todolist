import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:test_todo/models/task.dart';

class TaskData extends ChangeNotifier {
  final CollectionReference tasksCollection =
  FirebaseFirestore.instance.collection('tasks');

  List<Task> tasks = [];

  TaskData() {
    fetchTasks();
  }

  Future<void> fetchTasks() async {
    try {
      final querySnapshot = await tasksCollection.get();
      tasks = querySnapshot.docs
          .map((doc) => Task(id: doc.id, name: doc['name']))
          .toList();
      notifyListeners();
    } catch (e) {
      print('Failed to fetch tasks: $e');
    }
  }

  Future<void> addTask(String newTaskTitle) async {
    try {
      final docRef = await tasksCollection.add({'name': newTaskTitle});
      tasks.add(Task(id: docRef.id, name: newTaskTitle));
      notifyListeners();
    } catch (e) {
      print('Failed to add task: $e');
    }
  }

  Future<void> updateTaskName(Task task, String newName) async {
    try {
      await tasksCollection.doc(task.id).update({'name': newName});
      task.name = newName;
      notifyListeners();
    } catch (e) {
      print('Failed to update task name: $e');
    }
  }

  Future<void> deleteTask(Task task) async {
    try {
      await tasksCollection.doc(task.id).delete();
      tasks.remove(task);
      notifyListeners();
    } catch (e) {
      print('Failed to delete task: $e');
    }
  }

  Future<void> updateTask(Task task) async {
    try {
      await tasksCollection.doc(task.id).update({'name': task.name});
      final updatedTaskSnapshot = await tasksCollection.doc(task.id).get();
      final updatedTask = Task(
        id: task.id,
        name: updatedTaskSnapshot['name'],
      );
      final updatedTaskIndex = tasks.indexWhere((t) => t.id == task.id);
      if (updatedTaskIndex != -1) {
        tasks[updatedTaskIndex] = updatedTask;
      }
      notifyListeners();
    } catch (e) {
      print('Failed to update task: $e');
    }
  }


}
