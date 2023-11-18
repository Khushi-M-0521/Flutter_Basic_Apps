import 'package:flutter/material.dart';
import 'package:task_manager/widgets/tasks_display/task_card.dart';

class TasksList extends StatelessWidget{
  const TasksList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 1,
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
          onDismissed: (direction){},
          child: const TaskCard(),
        ),
      ),
    );
  }

}