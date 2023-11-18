import 'package:flutter/material.dart';

class SegregateTasks extends StatelessWidget{
  const SegregateTasks({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        OutlinedButton(onPressed: (){}, child: const Text('Completed Tasks: '),),
        const SizedBox(width: 30),
        OutlinedButton(onPressed: (){}, child: const Text('Incomplete Tasks: ')),
      ],
    );
  }

}