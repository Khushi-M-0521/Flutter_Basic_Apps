import 'package:flutter/material.dart';
import 'package:task_manager/widgets/screens/new_edit_task.dart';
import 'package:task_manager/widgets/tasks_display/tasks_display.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  void _openAddTaskOverlay(context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) =>const  NewEditTask(),
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
