import 'package:flutter/material.dart';

class NewExpense extends StatefulWidget{
  const NewExpense({super.key});

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }

}



class _NewExpense extends State<NewExpense>{
  final _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return   Padding(
      padding:const  EdgeInsets.all(16),
      child: Column(children: [
        TextField(
          controller: _titleController,
          keyboardType: TextInputType.text,
          maxLength: 50,
          decoration: const InputDecoration(label: Text('Title')),
        ),
        Row(
          children: [
            ElevatedButton(onPressed: (){
              print(_titleController.text);
            }, child: const Text('Save Expense'))
          ],
        )
      ],),
    );
  }

}