import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/widgets/screens/new_edit_task.dart';

class TaskCard extends StatefulWidget {
  const TaskCard(this.task, {super.key,required this.onTaskDone});

  final Task task;
  final void Function(Task, bool?) onTaskDone;

  @override
  State<TaskCard> createState() {
    return _TaskCard();
  }
}

class _TaskCard extends State<TaskCard> {
  late Task task;

  @override
  void initState() {
    super.initState();
    task = widget.task;
  }

  void _openAddTaskOverlay(context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewEditTask(
        editTask,
        editTitle: task.title,
        editDescription: task.description,
        editcategory: task.category,
        editPriority: task.priority,
        editAssignedDate: task.assignedDate,
        editDueDate: task.dueDate,
      ),
      useSafeArea: true,
      isScrollControlled: true,
      //useRootNavigator: true,
    );
  }

  void editTask(Task t) {
    taskBox.remove(task.id);
    taskBox.put(t);
    setState(() {
      task = t;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String timeleft = '';
    if (now.isBefore(task.dueDate)) {
      Duration left = task.dueDate.difference(now);
      if (left.inDays != 0) {
        timeleft = '${left.inDays} days ';
      } else if (left.inHours != 0) {
        timeleft = '${left.inHours} hrs. ';
      } else if (left.inDays != 0) {
        timeleft = '${left.inMinutes} mins.';
      } else {
        timeleft = 'passed';
      }
    } else {
      timeleft = 'passed';
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
                Checkbox(
                    value: task.isDone,
                    onChanged: (isCheck) {
                      widget.onTaskDone(task,isCheck);
                      // taskBox.remove(task.id);
                      // setState(() {
                      //   task.isDone = isCheck ?? task.isDone;
                      //   taskBox.put(task);
                      // });
                    }),
                const Spacer(),
                Text(
                  task.isDone?'  ${task.title} -':task.title,
                  style: task.isDone
                      ? Theme.of(context).textTheme.headlineSmall!.copyWith(
                          decoration: TextDecoration.lineThrough,
                          decorationThickness: 2)
                      : Theme.of(context).textTheme.headlineSmall,
                ),
                const Spacer(),
                CircleAvatar(
                  backgroundColor: (!task.isDone)
                      ? Theme.of(context).colorScheme.primaryContainer
                      : Theme.of(context)
                          .colorScheme
                          .primaryContainer
                          .withOpacity(0.5),
                  child: IconButton(
                      color: (!task.isDone)
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context)
                              .colorScheme
                              .onPrimaryContainer
                              .withOpacity(0.5),
                      onPressed: () {
                        if (task.isDone) {
                          return;
                        }
                        _openAddTaskOverlay(context);
                      },
                      icon: const Icon(Icons.edit)),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Text(
                task.description ?? ' ',
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                textWidthBasis: TextWidthBasis.parent,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Assigned on: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  formattedDate(task.assignedDate),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Text(
                  'Due on: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  formattedDate(task.dueDate),
                  style: Theme.of(context).textTheme.bodyMedium,
                )
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'Category: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  task.category.category.toUpperCase(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const Spacer(),
                Text(
                  'Time left: ',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text(
                  timeleft,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
