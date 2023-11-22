import 'package:flutter/material.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/widgets/tasks_display/task_card.dart';

class TasksList extends StatelessWidget{
  const TasksList(this._tasks,{super.key, required this.removeTask});

  final List<Task> _tasks;
  final void Function(Task) removeTask;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (ctx,index)=>Dismissible(
          key: UniqueKey(),
          background: Container(
            child: const Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.delete,size: 30,),
                  Spacer(),
                  Icon(Icons.delete,size: 30,),
                  SizedBox(width: 15,),
                ],
              ),),
          onDismissed: (direction){ removeTask(_tasks[index]); },
          child: TaskCard(_tasks[index]),
        ),
      ),
    );
  }

}