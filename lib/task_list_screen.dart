import 'package:flutter/material.dart';
import 'task.dart';  // Import the Task model

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // List to store the tasks
  final List<Task> _tasks = [];

  // Controller for the input field where users type the task name
  final TextEditingController _taskController = TextEditingController();

  // Method to add a new task to the list
  void _addTask() {
    if (_taskController.text.isEmpty) return;  // Do not add an empty task
    setState(() {
      _tasks.add(Task(name: _taskController.text));  // Create and add a new task
      _taskController.clear();  // Clear the text field after adding
    });
  }

  // Method to toggle task completion status
  void _toggleCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;  // Update the task's isCompleted property
    });
  }

  // Method to remove a task from the list
  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);  // Remove the task from the list
    });
  }

  @override
  void dispose() {
    _taskController.dispose();  // Dispose of the controller to prevent memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),
      ),
      body: Column(
        children: [
          // Input field and "Add" button for new tasks
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Input field to enter a new task
                Expanded(
                  child: TextField(
                    controller: _taskController,  // Binds the input field to the controller
                    decoration: InputDecoration(
                      labelText: 'Enter task name',
                    ),
                  ),
                ),
                SizedBox(width: 8),  // Add spacing between the TextField and Button
                // Button to add a task
                ElevatedButton(
                  onPressed: _addTask,  // Calls the _addTask method
                  child: Text('Add'),
                ),
              ],
            ),
          ),
          // Display the list of tasks
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,  // Number of tasks
              itemBuilder: (context, index) {
                final task = _tasks[index];  // Get the task at this index
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,  // Checkbox reflects the task completion status
                    onChanged: (bool? value) {
                      if (value != null) {
                        _toggleCompletion(task);  // Toggle the completion status
                      }
                    },
                  ),
                  title: Text(
                    task.name,
                    style: TextStyle(
                      // Strike through the text if the task is completed
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),  // Trash icon for deletion
                    onPressed: () {
                      _deleteTask(task);  // Delete the task when pressed
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
