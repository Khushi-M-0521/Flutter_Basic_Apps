import 'package:flutter/material.dart';

class NewEditTask extends StatefulWidget {
  const NewEditTask({super.key});

  @override
  State<StatefulWidget> createState() {
    return _NewEditTask();
  }
}

class _NewEditTask extends State<NewEditTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityControlloer = TextEditingController(); 

  @override
  void initState(){
    super.initState();
    _titleController.text='homework';
    _descriptionController.text='description.............................////////////...................................................................................................................';
    _priorityControlloer.text='1';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityControlloer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: MediaQuery.of(context).size.width - 20,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                maxLength: 30,
                decoration: const InputDecoration(
                  label: Text('Title'),
                  hintText: 'Title of your task',
                ),
              ),
              TextField(
                controller: _descriptionController,
                minLines: 1,
                maxLines: 4,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Description',
                  hintText: 'Detail of task',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 15),
                  Column(
                    children: [
                      const Text('Caterory: ',textAlign: TextAlign.start,),
                      //SizedBox(height: 10),
                      DropdownButton(
                        value: 1,
                        items:const [ DropdownMenuItem(value: 1, child: Text('Category1'),),
                                DropdownMenuItem(value: 2, child: Text('Category2'),),
                        ],
                        onChanged: (value){},
                      ),
                    ],
                  ),
                  const Spacer(),
                  Expanded(
                    child: TextField(
                      controller: _priorityControlloer,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Priority',
                        helperText: '1 is highest priority',
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Text('Assigned on: date'),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month),),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Due on: date'),
                  const SizedBox(width: 32),
                  IconButton(onPressed: (){}, icon: const Icon(Icons.calendar_month),),
                ],
              ),
              const SizedBox(height:10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){},
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: (){}, 
                    child: const Text('Save Task'),),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
