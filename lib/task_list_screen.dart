import 'package:flutter/material.dart';
import 'task.dart';  // Import the Task model to create task objects

// TaskListScreen is a StatefulWidget that manages the list of tasks and allows adding, completing, and deleting tasks
class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();  // Create the mutable state for the TaskListScreen
}

// _TaskListScreenState manages the state (list of tasks) and updates the UI when changes occur
class _TaskListScreenState extends State<TaskListScreen> {
  // A list to store all the tasks. It is a dynamic list of Task objects.
  final List<Task> _tasks = [];

  // A TextEditingController to control and capture user input from the TextField for task names
  final TextEditingController _taskController = TextEditingController();

  // Method to add a new task to the task list when the user taps the "Add" button
  void _addTask() {
    // Check if the input field is not empty
    if (_taskController.text.isEmpty) return;  // If the input is empty, do nothing and return
    setState(() {
      // Add a new task to the list with the entered name and default completion status (false)
      _tasks.add(Task(name: _taskController.text));
      _taskController.clear();  // Clear the input field after adding the task
    });
  }

  // Method to toggle the completion status of a task (called when the user checks/unchecks a checkbox)
  void _toggleCompletion(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;  // Flip the isCompleted status of the task
    });
  }

  // Method to remove a task from the task list (called when the user taps the delete icon)
  void _deleteTask(Task task) {
    setState(() {
      _tasks.remove(task);  // Remove the task from the list
    });
  }

  // This method is called when the widget is removed from the tree (cleanup function)
  @override
  void dispose() {
    _taskController.dispose();  // Dispose of the TextEditingController to free up resources
    super.dispose();  // Call the superclass dispose method
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Manager'),  // Title in the app bar
      ),
      body: Column(
        children: [
          // Padding for the input row containing the TextField and the "Add" button
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Expanded widget to allow the TextField to take up available horizontal space
                Expanded(
                  child: TextField(
                    controller: _taskController,  // Bind the TextField to the controller
                    decoration: InputDecoration(
                      labelText: 'Enter task name',  // Placeholder text for the input field
                    ),
                  ),
                ),
                SizedBox(width: 8),  // Add a small space between the TextField and the button
                // Elevated button to add a task
                ElevatedButton(
                  onPressed: _addTask,  // Call _addTask method when button is pressed
                  child: Text('Add'),  // Button text
                ),
              ],
            ),
          ),
          // Expanded widget to make sure the ListView takes up all remaining vertical space
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,  // The number of tasks in the list
              itemBuilder: (context, index) {
                final task = _tasks[index];  // Get the task at the current index
                return ListTile(
                  leading: Checkbox(
                    value: task.isCompleted,  // The checkbox reflects the task's completion status
                    onChanged: (bool? value) {
                      if (value != null) {
                        _toggleCompletion(task);  // Call _toggleCompletion when checkbox is toggled
                      }
                    },
                  ),
                  // Display the task's name, and add a strike-through style if the task is completed
                  title: Text(
                    task.name,
                    style: TextStyle(
                      // If the task is completed, strike through the task name; otherwise, display normally
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  // Add a delete icon button to remove the task from the list
                  trailing: IconButton(
                    icon: Icon(Icons.delete),  // Icon for the delete button
                    onPressed: () {
                      _deleteTask(task);  // Call _deleteTask when delete button is pressed
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
