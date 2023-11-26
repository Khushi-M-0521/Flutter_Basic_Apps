import 'package:flutter/material.dart';

class SegregateTasks extends StatelessWidget {
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
        OutlinedButton(
            onPressed: segregateCompleted,
            child: Text.rich(
              TextSpan(
                children: [
                TextSpan(
                    text: 'Completed: ',
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),),
                TextSpan(
                    text: completedTasks.toString(),
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),)
              ]),
            )),
        const Spacer(),
        OutlinedButton(
          onPressed: segregateIncompleted,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Incomplete: ',style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),),
                TextSpan(text: incompletedTasks.toString(),style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),),
              ]
            )
          ),
        ),
        const Spacer(),
        OutlinedButton(
          onPressed: removeSegregation,
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: 'Total: ',style: Theme.of(context).textTheme.labelMedium!.copyWith(color: Theme.of(context).colorScheme.primary),),
                TextSpan(text: (completedTasks + incompletedTasks).toString(), style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary),)
              ]
            )
          ),
        ),
      ],
    );
  }
}
