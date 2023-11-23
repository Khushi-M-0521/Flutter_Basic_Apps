import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(this.task,{super.key});

  final Task task;

  @override
  State<TaskCard> createState() {
    return _TaskCard();
  }
}

class _TaskCard extends State<TaskCard> {
  
  @override
  Widget build(BuildContext context) {
    Task task=widget.task;
    DateTime now=DateTime.now();
    String timeleft='';
    if(now.isBefore(task.dueDate)){
      Duration left=task.dueDate.difference(now);
      if(left.inDays!=0){
      timeleft='${left.inDays} days ';
      }
      else if(left.inHours!=0){
        timeleft='${left.inHours} hrs. ';
      }
      else if(left.inDays!=0){
        timeleft='${left.inMinutes} mins.';
      }
      else{
        timeleft='passed';
      }
    }
    else{
      timeleft='passed';
    }
    
    return Card(
      margin: const EdgeInsets.all(5),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Checkbox(value: task.isDone, onChanged: (isCheck) {
                  taskBox.remove(task.id);
                  setState(() {
                    task.isDone=isCheck??task.isDone;
                    taskBox.put(task);
                  });
                }),
                const Spacer(),
                Text(task.title),
                const Spacer(),
                const CircleAvatar(
                  child: Icon(Icons.edit),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                task.description??' ',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textWidthBasis: TextWidthBasis.parent,
              ),
            ),
            
            const SizedBox(height: 4),
            Row(
              children: [
                Text('Assigned on: ${formattedDate(task.assignedDate)}'),
                const Spacer(),
                Text('Due on: ${formattedDate(task.dueDate)}'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text('Category: ${task.category.category.toUpperCase()}'),
                const Spacer(),
                Text('Time left: $timeleft'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
