import 'package:flutter/material.dart';

class SegregateTasks extends StatelessWidget{
  const SegregateTasks({
    super.key,
    required this.completedTasks,
    required this.incompletedTasks,
    required this.segregateCompleted,
    required this.segregateIncompleted,
    required this.removeSegregation,
  });

  final int completedTasks;
  final int incompletedTasks;
  final void Function() segregateCompleted;
  final void Function() segregateIncompleted;
  final void Function() removeSegregation;


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(onPressed: segregateCompleted, child: Text('Completed: $completedTasks'),),
        const SizedBox(width: 10),
        OutlinedButton(onPressed: segregateIncompleted, child: Text('Incomplete: $incompletedTasks')),
        const SizedBox(width: 10),
        OutlinedButton(onPressed: removeSegregation, child: Text('Total: ${completedTasks+incompletedTasks}')),
      ],
    );
  }

}