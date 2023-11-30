import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/constants.dart';
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
    required this.onTaskDone,
  });

  List<Task> _tasksToDisplay;
  final void Function(Task) removeTask;
  final List<Task> Function() filterAllTasks;
  final List<Task> Function(DateTime) filterTasksOn;
  final List<Task> Function(DateTime) filterTasksFrom;
  final List<Task> Function(DateTime) filterDueTasksOn;
  final List<Task> Function(DateTime) filterDueTasksTill;
  final List<Task> Function() filterDelayed;
  final List<Task> Function(int) filterCategory;
  final void Function(Task,bool?) onTaskDone;

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
  DateTime now=DateTime.now();
  List<Task> _segregatedTasks=[];
  bool _isSegregated=false;

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
      _isSegregated=false;
    });
    
  }

  Future<void> _setFilter(int? id) async {
    switch(id){
      case null:
        return;
      case 0:
        widget.filterAllTasks();
        setState(() {
          filterId=0;
          widget._tasksToDisplay=widget.filterAllTasks(); 
          _isSegregated=false;  
        });
      case 1:
        setState(() {
          filterId=1; 
          widget._tasksToDisplay=widget.filterTasksOn(_tasksOn);
          _isSegregated=false;
        });
        
      case 2:
        setState(() {
          filterId=2;   
          widget._tasksToDisplay=widget.filterTasksFrom(_tasksFrom); 
          _isSegregated=false;
        });
      case 3:
        setState(() {
          filterId=3;   
          widget._tasksToDisplay=widget.filterDueTasksOn(_dueTasksOn); 
          _isSegregated=false;
        });
      case 4:
        setState(() {
          filterId=4;    
          widget._tasksToDisplay=widget.filterDueTasksTill(_dueTasksTill);
          _isSegregated=false;
        });
      case 5:
        setState(() {
          filterId=5;  
          widget._tasksToDisplay=widget.filterDelayed();  
          _isSegregated=false;
        });
      case 6:
        setState(() {
          filterId=6; 
          if(_category!=null){ 
          widget._tasksToDisplay=widget.filterCategory(_category!.id); 
          }
          _isSegregated=false;
        });
    }
  }

  void _segregateComplete() {
    setState(() {
     _segregatedTasks = widget._tasksToDisplay.where((task) => task.isDone).toList();
    _isSegregated=true; 
    });
  }

  void _segregateIncomplete() {
    setState(() {
      _segregatedTasks = widget._tasksToDisplay.where((task) => !task.isDone).toList();
    _isSegregated=true;
    });
  }

  void _removeSegregation(){
    setState(() {
      _isSegregated=false;
    });
  }

  int get completedTasks{
    return widget._tasksToDisplay.where((task) => task.isDone).toList().length;
  }

  int get incompletedTasks{
    return widget._tasksToDisplay.where((task) => !task.isDone).toList().length;
  }

  @override
  Widget build(BuildContext context) {
    final width=MediaQuery.of(context).size.width;
    (_isSegregated?_segregatedTasks:widget._tasksToDisplay).sort((task1, task2) => sortTasks(task1, task2),);
    
    return Center(
      child: Container(
        padding: const EdgeInsets.all(5),
        child: Column(
          children: width<600?[
            Filter(
              //key: UniqueKey(),
              tasksOn: _tasksOn,
              tasksFrom: _tasksFrom,
              dueTasksOn: _dueTasksOn,
              dueTasksTill: _dueTasksTill,
              category: _category,
              pickedDate: _pickDateTime, 
              setCategory: _setCategory, 
              filterId: filterId, 
              setFilter:  _setFilter,
            ),
            const SizedBox(
              height: 10,
            ),
            SegregateTasks(
              completedTasks: completedTasks, 
              incompletedTasks: incompletedTasks, 
              segregateCompleted: _segregateComplete, 
              segregateIncompleted: _segregateIncomplete, 
              removeSegregation: _removeSegregation,
            ),
            const SizedBox(
              height: 10,
            ),
            (_isSegregated?_segregatedTasks:widget._tasksToDisplay).isEmpty ?
            Image.asset(
              'assests/images/TaskUnmatched.png',
              color: Theme.of(context).colorScheme.primary,
            ):
            TasksList(
              _isSegregated?_segregatedTasks:widget._tasksToDisplay, 
              removeTask: widget.removeTask,
              onTaskDone: widget.onTaskDone,),
          ]:
          [
            Row(
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
              filterId: filterId, 
              setFilter:  _setFilter,
            ),
            const SizedBox(
              width: 20,
            ),
            SegregateTasks(
              completedTasks: completedTasks, 
              incompletedTasks: incompletedTasks, 
              segregateCompleted: _segregateComplete, 
              segregateIncompleted: _segregateIncomplete, 
              removeSegregation: _removeSegregation,
            ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            (_isSegregated?_segregatedTasks:widget._tasksToDisplay).isEmpty ?
            Center(
              child: Image.asset(
                'assests/images/TaskUnmatched.png',
                color: Theme.of(context).colorScheme.primary,
                height: 200,
              ),
            ):
            TasksList(
              _isSegregated?_segregatedTasks:widget._tasksToDisplay, 
              removeTask: widget.removeTask,
              onTaskDone: widget.onTaskDone,),
          ],
        ),
      ),
    );
  }
}
