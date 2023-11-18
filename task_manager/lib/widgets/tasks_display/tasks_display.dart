import 'package:flutter/material.dart';
import 'package:task_manager/widgets/tasks_display/filter.dart';
import 'package:task_manager/widgets/tasks_display/segregate_tasks.dart';
import 'package:task_manager/widgets/tasks_display/task_list.dart';

class TasksDisplay extends StatefulWidget{
  const TasksDisplay({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TasksDisplay();
  }

}

class _TasksDisplay extends State<TasksDisplay>{

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: const Column(
          children: [
            Filter(),
            SizedBox(height: 20,),
            SegregateTasks(),
            SizedBox(height: 20,),
            TasksList(),
          ],
        ),
      ),
    );
  }

}