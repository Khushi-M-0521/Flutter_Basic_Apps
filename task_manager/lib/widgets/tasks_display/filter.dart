import 'package:flutter/material.dart';

class Filter extends StatelessWidget{
  const Filter({super.key});

  @override
  Widget build(BuildContext context) {
    const calender=Icon(Icons.calendar_month);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.filter_list),
        const SizedBox(width: 20,),
        DropdownButton(
          value: 1,
          alignment: Alignment.center,
          items:  [
          const DropdownMenuItem(value: 1,child: Text('All Tasks'),),
          DropdownMenuItem(value: 2,child: Row(
            children: [
              const Text('Tasks on: '),
              IconButton(onPressed: (){}, icon: calender),
            ],
          ),),
          DropdownMenuItem(value: 3,child: Row(
            children: [
              const Text('Tasks from:'),
              IconButton(onPressed: (){}, icon: calender),
            ],
          ),),
          DropdownMenuItem(value: 4,child: Row(
            children: [
              const Text('Due tasks on: '),
              IconButton(onPressed: (){}, icon: calender),
            ],
          ),),
          DropdownMenuItem(value: 5,child: Row(
            children: [
              const Text('Due tasks till: '),
              IconButton(onPressed: (){}, icon: calender),
            ],
          ),),
          const DropdownMenuItem(value: 6,child: Text('Delayed tasks: '),),
          const DropdownMenuItem(value: 7,child: Text('Caterogized as: '),),
        ], onChanged: (val){},)
      ],
    );
  }
  
}
