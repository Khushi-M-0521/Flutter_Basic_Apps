import 'package:flutter/material.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/widgets/tasks_display/task_card.dart';

class TasksList extends StatelessWidget{
  const TasksList(this._tasks,{super.key, required this.removeTask,required this.onTaskDone});

  final List<Task> _tasks;
  final void Function(Task) removeTask;
  final void Function(Task,bool?) onTaskDone;

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;

    return Expanded(
      child: width<600?ListView.builder(
        itemCount: _tasks.length,
        itemBuilder: (ctx,index)=>Dismissible(
          key: UniqueKey(),
          background: Row(
                children: [
                  const SizedBox(width: 15,),
                  Icon(Icons.delete,size: 30,color: Theme.of(context).colorScheme.error,),
                ],
              ),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){ removeTask(_tasks[index]); },
          child: TaskCard(_tasks[index],onTaskDone:onTaskDone),
        ),
      ):GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          //childAspectRatio: 3,
          mainAxisExtent: 190), 
        itemCount: _tasks.length,
        itemBuilder: (ctx,index)=>Dismissible(
          key: UniqueKey(),
          background: Row(
                children: [
                  const SizedBox(width: 15,),
                  Icon(Icons.delete,size: 30,color: Theme.of(context).colorScheme.error,),
                ],
              ),
          direction: DismissDirection.startToEnd,
          onDismissed: (direction){ removeTask(_tasks[index]); },
          child: TaskCard(_tasks[index],onTaskDone:onTaskDone),
        ),
      ),
    );
  }

}