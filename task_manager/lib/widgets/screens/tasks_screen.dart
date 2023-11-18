import 'package:flutter/material.dart';
import 'package:task_manager/widgets/tasks_display/tasks_display.dart';



class TasksScreen extends StatelessWidget{
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.add_task_outlined)),
        ],
       ),
      body: const TasksDisplay(),
    );
  }

}