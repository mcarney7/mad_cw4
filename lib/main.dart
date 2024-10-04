import 'package:flutter/material.dart';
import 'task_list_screen.dart';  // Import the TaskListScreen, which contains the main app logic for task management

void main() {
  runApp(TaskApp());  // The entry point of the app that starts running the TaskApp
}

// TaskApp is a StatelessWidget that serves as the root widget of the application
class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',  // Title of the app
      theme: ThemeData(
        primarySwatch: Colors.blue,  // Set the primary color of the app's theme
      ),
      home: TaskListScreen(),  // Set the TaskListScreen as the home screen of the app
    );
  }
}
