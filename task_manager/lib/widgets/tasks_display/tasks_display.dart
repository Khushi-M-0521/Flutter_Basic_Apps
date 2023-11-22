import 'package:flutter/material.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/widgets/tasks_display/filter.dart';
import 'package:task_manager/widgets/tasks_display/segregate_tasks.dart';
import 'package:task_manager/widgets/tasks_display/task_list.dart';

class TasksDisplay extends StatefulWidget {
  const TasksDisplay(this._tasksToDisplay,{super.key,required this.removeTask});

  final _tasksToDisplay;
  final void Function(Task) removeTask;

  @override
  State<TasksDisplay> createState() {
    return _TasksDisplay();
  }
}

class _TasksDisplay extends State<TasksDisplay> {
  late List<Task> _tasksToDisplay;
  DateTime _tasksOn = DateTime.now();
  DateTime _tasksFrom = DateTime.now().subtract(Duration(days: 1));
  DateTime _dueTasksOn = DateTime.now();
  DateTime _dueTasksTill = DateTime.now().add(Duration(days: 1));
  Category? _category;
  int _filterId=0;
  DateTime now=DateTime.now();

  @override
  void initState(){
    super.initState();
    _tasksToDisplay=widget._tasksToDisplay;
  }

  Future _pickDateTime(
      {required initialDate,
      required int who}) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(now.year-1),
      lastDate: DateTime(now.year+1),
    );
    setState(() {
      switch (who) {
        case 1:
          _tasksOn = pickedDate??_tasksOn;
        case 2:
          _tasksFrom = pickedDate??_tasksFrom;
        case 3:
          _dueTasksOn = pickedDate??_dueTasksOn;
        case 4:
          _dueTasksTill = pickedDate??_dueTasksTill;
      }
    });
    
  }

  void _setCategory(int? ctgId){
    setState(() {
      _category=categoryBox.get(ctgId!);
    });
    
  }

  void _setFilter(int? id){
    switch(id){
      case null:
        return;
      case 0:
        setState(() {
          _filterId=0;    
        });
      case 1:
        setState(() {
          _filterId=1;    
        });
      case 2:
        setState(() {
          _filterId=2;    
        });
      case 3:
        setState(() {
          _filterId=3;    
        });
      case 4:
        setState(() {
          _filterId=4;    
        });
      case 5:
        setState(() {
          _filterId=5;    
        });
      case 6:
        setState(() {
          _filterId=6;    
        });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            Filter(
              tasksOn: _tasksOn,
              tasksFrom: _tasksFrom,
              dueTasksOn: _dueTasksOn,
              dueTasksTill: _dueTasksTill,
              category: _category,
              pickedDate: _pickDateTime, 
              setCategory: _setCategory, 
              filterId: _filterId, 
              setFilter:  _setFilter,
            ),
            const SizedBox(
              height: 20,
            ),
            const SegregateTasks(),
            const SizedBox(
              height: 20,
            ),
            TasksList(_tasksToDisplay, removeTask: widget.removeTask,),
          ],
        ),
      ),
    );
  }
}
