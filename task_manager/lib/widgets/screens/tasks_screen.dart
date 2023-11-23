import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/objectbox.g.dart';
import 'package:task_manager/widgets/screens/new_edit_task.dart';
import 'package:task_manager/widgets/tasks_display/tasks_display.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({super.key});

  @override
  State<TasksScreen> createState() {
    return _TasksScreen();
  }
}

class _TasksScreen extends State<TasksScreen> {
  List<Task> _tasksToDisplay = taskBox.getAll();

  void _addOrEditTask(Task task) {
    taskBox.put(task);
    setState(() {
      _tasksToDisplay.add(task);
    });
  }

  void _removeTask(Task task) {
    taskBox.remove(task.id);
    setState(() {
      _tasksToDisplay.remove(task);
    });
  }

  List<Task> _filterAllTasks() {
      _tasksToDisplay = taskBox.getAll();
      return _tasksToDisplay;
  }

  List<Task> _filterTasksOn(DateTime date) {
    queryTasksOn.param(Task_.assignedDate).value = date.millisecondsSinceEpoch;
    final tasks = queryTasksOn.find();
    _tasksToDisplay = tasks;
    return _tasksToDisplay;
  }

  List<Task> _filterTasksFrom(DateTime date) {
    queryTasksFrom.param(Task_.assignedDate).value = date.millisecondsSinceEpoch;
    final tasks = queryTasksFrom.find();
    _tasksToDisplay = tasks;
    return _tasksToDisplay;
  }

  List<Task> _filterDueTasksOn(DateTime date) {
    queryDueTasksOn.param(Task_.dueDate).value = date.add(const Duration(hours: 23, minutes: 59, seconds: 59)).millisecondsSinceEpoch;
    final tasks = queryDueTasksOn.find();
    _tasksToDisplay = tasks;
    return _tasksToDisplay;
  }

  List<Task> _filterDueTasksTill(DateTime date) {
    queryDueTasksTill.param(Task_.dueDate).value = date.add(const Duration(hours: 23, minutes: 59, seconds: 59)).millisecondsSinceEpoch;
    final tasks = queryDueTasksTill.find();
    _tasksToDisplay = tasks;
    return _tasksToDisplay;
  }

  List<Task> _filterDelayed() {
    final tasks = queryDelayed.find();
    _tasksToDisplay = tasks;
    return _tasksToDisplay;
  }

  List<Task> _filterCategory(int ctgId) {
    queryCategory.param(Task_.categoryId).value = ctgId;
    final tasks = queryCategory.find();
    _tasksToDisplay = tasks;
    return _tasksToDisplay;
  }

  void _openAddTaskOverlay(context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewEditTask(_addOrEditTask),
      useSafeArea: true,
      isScrollControlled: true,
      //useRootNavigator: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                _openAddTaskOverlay(context);
              },
              icon: const Icon(Icons.add_task_outlined)),
        ],
      ),
      body: TasksDisplay(
        _tasksToDisplay,
        key: UniqueKey(),
        removeTask: _removeTask, 
        filterAllTasks: _filterAllTasks, 
        filterTasksOn: _filterTasksOn, 
        filterTasksFrom: _filterTasksFrom, 
        filterDueTasksOn: _filterDueTasksOn, 
        filterDueTasksTill: _filterDueTasksTill, 
        filterDelayed: _filterDelayed, 
        filterCategory: _filterCategory,
      ),
    );
  }
}
