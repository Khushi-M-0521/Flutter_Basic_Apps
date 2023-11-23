import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/widgets/tasks_display/filter.dart';
import 'package:task_manager/widgets/tasks_display/segregate_tasks.dart';
import 'package:task_manager/widgets/tasks_display/task_list.dart';

// ignore: must_be_immutable
class TasksDisplay extends StatefulWidget {
  TasksDisplay(this._tasksToDisplay,{
    super.key,
    required this.removeTask,
    required this.filterAllTasks,
    required this.filterTasksOn,
    required this.filterTasksFrom,
    required this.filterDueTasksOn,
    required this.filterDueTasksTill,
    required this.filterDelayed,
    required this.filterCategory,
  });

  List<Task> _tasksToDisplay;
  final void Function(Task) removeTask;
  final void Function() filterAllTasks;
  final List<Task> Function(DateTime) filterTasksOn;
  final List<Task> Function(DateTime) filterTasksFrom;
  final List<Task> Function(DateTime) filterDueTasksOn;
  final List<Task> Function(DateTime) filterDueTasksTill;
  final List<Task> Function() filterDelayed;
  final List<Task> Function(int) filterCategory;

  @override
  State<TasksDisplay> createState() {
    return _TasksDisplay();
  }
}

class _TasksDisplay extends State<TasksDisplay> {
  DateTime _tasksOn = DateTime.now();
  DateTime _tasksFrom = DateTime.now().subtract(const Duration(days: 1));
  DateTime _dueTasksOn = DateTime.now();
  DateTime _dueTasksTill = DateTime.now().add(const Duration(days: 1));
  Category? _category;
  int _filterId=0;
  DateTime now=DateTime.now();

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
          widget._tasksToDisplay=widget.filterTasksOn(_tasksOn);
        case 2:
          _tasksFrom = pickedDate??_tasksFrom;
          widget._tasksToDisplay=widget.filterTasksFrom(_tasksFrom);
        case 3:
          _dueTasksOn = pickedDate??_dueTasksOn;
          widget._tasksToDisplay=widget.filterDueTasksOn(_dueTasksOn);
        case 4:
          _dueTasksTill = pickedDate??_dueTasksTill;
          widget._tasksToDisplay=widget.filterDueTasksTill(_dueTasksTill);
      }
    });
    
  }

  void _setCategory(int? ctgId){
    setState(() {
      _category=categoryBox.get(ctgId!);
      widget._tasksToDisplay=widget.filterCategory(_category!.id);
    });
    
  }

  Future<void> _setFilter(int? id) async {
    switch(id){
      case null:
        return;
      case 0:
        widget.filterAllTasks();
        setState(() {
          _filterId=0;    
        });
      case 1:
        setState(() {
          _filterId=1; 
          widget._tasksToDisplay=widget.filterTasksOn(_tasksOn);
        });
        
      case 2:
        setState(() {
          _filterId=2;   
          widget._tasksToDisplay=widget.filterTasksFrom(_tasksFrom); 
        });
      case 3:
        setState(() {
          _filterId=3;   
          widget._tasksToDisplay=widget.filterDueTasksOn(_dueTasksOn); 
        });
      case 4:
        setState(() {
          _filterId=4;    
          widget._tasksToDisplay=widget.filterDueTasksTill(_dueTasksTill);
        });
      case 5:
        setState(() {
          _filterId=5;  
          widget._tasksToDisplay=widget.filterDelayed();  
        });
      case 6:
        setState(() {
          _filterId=6;  
          print('aah reha');
          if(_category!=null){ 
          print('ok');
          widget._tasksToDisplay=widget.filterCategory(_category!.id); 
          }
        });
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Column(
          children: [
            Filter(
              //key: UniqueKey(),
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
            TasksList(widget._tasksToDisplay, removeTask: widget.removeTask,),
          ],
        ),
      ),
    );
  }
}
