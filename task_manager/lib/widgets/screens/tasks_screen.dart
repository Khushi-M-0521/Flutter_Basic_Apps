import 'package:flutter/material.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/widgets/screens/new_edit_task.dart';
import 'package:task_manager/widgets/tasks_display/tasks_display.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});
  
  @override
  State<TasksScreen> createState() {
    return _TasksScreen();
  }

}

class _TasksScreen extends State<TasksScreen>{
  

  void _addOrEditTask(Task task){
    taskBox.put(task);
    print(task);
  }

  void _openAddTaskOverlay(context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>  NewEditTask(_addOrEditTask),
      useSafeArea: true,
      isScrollControlled: true,
      //useRootNavigator: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _openAddTaskOverlay(context);
              },
              icon: const Icon(Icons.add_task_outlined)),
        ],
      ),
      body: const TasksDisplay(),
    );
  }
}
