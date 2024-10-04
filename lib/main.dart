import 'package:flutter/material.dart';
import 'task_list_screen.dart';  // Import TaskListScreen

void main() {
  runApp(TaskApp());
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskListScreen(),  // Set the TaskListScreen as the home screen
    );
  }
}
