// This file defines the Task model which represents each task in the app

class Task {
  String name;  // Name of the task (entered by the user)
  bool isCompleted;  // Boolean to indicate whether the task is completed or not

  // Constructor to initialize a new task.
  // By default, the task is not completed when created.
  Task({required this.name, this.isCompleted = false});
}
