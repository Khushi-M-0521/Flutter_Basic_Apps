import 'dart:async';
import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/objectbox.g.dart';

class NewEditTask extends StatefulWidget {
  const NewEditTask(
    this._addOrEditTask, {
    super.key,
    this.editTitle,
    this.editDescription,
    this.editcategory,
    this.editPriority,
    this.editAssignedDate,
    this.editDueDate,
  });

  final void Function(Task) _addOrEditTask;
  final String? editTitle;
  final String? editDescription;
  final Category? editcategory;
  final int? editPriority;
  final DateTime? editAssignedDate;
  final DateTime? editDueDate;

  @override
  State<StatefulWidget> createState() {
    return _NewEditTask();
  }
}

class _NewEditTask extends State<NewEditTask> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priorityControlloer = TextEditingController();
  TextEditingController? _addCatergoryController;
  late DateTime _assignedTime;
  late DateTime _dueTime;
  Category? _category;
  List<Category> _allcategory = categoryBox.getAll();
  late List<Category> managableCategories;

  void getAssignedDateTime() async {
    final initialDate = _assignedTime;
    final firstDate = DateTime(
        _assignedTime.year - 1, _assignedTime.month, _assignedTime.day);
    final lastDate = _assignedTime;
    final pickedTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _assignedTime = pickedTime ?? DateTime.now();
    });
  }

  void getDueDateTime() async {
    final initialDate = _dueTime;
    final firstDate = _assignedTime;
    final lastDate = DateTime(_dueTime.year + 1, _dueTime.month, _dueTime.day);
    DateTime? pickedTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedTime != null) {
      pickedTime =
          pickedTime.add(const Duration(hours: 23, minutes: 59, seconds: 59));
    }
    setState(() {
      _dueTime = pickedTime ?? DateTime.now();
    });
  }

  Future<void> addCategory() async {
    if (_addCatergoryController!.text.isEmpty) {
      // ignore: use_build_context_synchronously
      await showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(
            'Category name not found !',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    final newCategory = Category(_addCatergoryController!.text);
    categoryBox.put(newCategory);
    setState(() {
      _allcategory.add(newCategory);
    });
    Navigator.pop(context);
  }

  void addCategoryDialog() {
    _addCatergoryController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Add Catergory',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _addCatergoryController,
                  maxLength: 15,
                  style: Theme.of(context).textTheme.bodyMedium,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    labelStyle: Theme.of(context).textTheme.labelLarge,
                    hintText: 'generally a word',
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Cancel'),
                    ),
                    ElevatedButton(
                      onPressed: addCategory,
                      child: const Text('Save'),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> removeCategory(int id) async {
    Category deleteCategory = categoryBox.get(id)!;
    await showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
            'Are you sure to delete ${deleteCategory.category.toUpperCase()} category?'),
        content: const Text(
            'By deleting this catergory, you are deleting all tasks under this catergory.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          ElevatedButton(
            onPressed: () {
              categoryBox.remove(id);
              queryCategory.param(Task_.categoryId).value = id;
              List<int> tasksIds =
                  queryCategory.find().map((task) => task.id).toList();
              taskBox.removeMany(tasksIds);
              Navigator.pop(context);
              setState(() {
                _allcategory = categoryBox.getAll();
                //managableCategories.removeAt(index);
              });
            },
            child: const Text('Yes'),
          )
        ],
      ),
    );
  }

  void manageCategoryDialog() {
    managableCategories = _allcategory.where((category) {
      queryCategory.param(Task_.categoryId).value = category.id;
      var tasks = queryCategory.find().where((task) => !task.isDone);
      return tasks.isEmpty;
    }).toList();

    showDialog(
      context: context,
      builder: ((ctx) => Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Manage Category',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '    Can delete category only if all tasks under that category are completed.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(
                    height: 300,
                    child: (managableCategories.isNotEmpty)
                        ? ListView.builder(
                            padding: const EdgeInsets.all(10),
                            itemCount: managableCategories.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Text(
                                    managableCategories[index]
                                        .category
                                        .toUpperCase(),
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () async {
                                      await removeCategory(
                                          managableCategories[index].id);
                                      // ignore: use_build_context_synchronously
                                      Navigator.pop(context);
                                      manageCategoryDialog();
                                    },
                                    icon: const Icon(Icons.delete),
                                  )
                                ],
                              );
                            },
                          )
                        : Center(
                            child: Text(
                              '   No categories can be managed. Either there are no more categories or there are categories with incompleted tasks',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text('OK'),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  void saveTask() {
    bool isValid = false;
    String? errorTitle;
    String? errorDescription;
    int? priority = int.tryParse(_priorityControlloer.text);

    if (_titleController.text.isEmpty) {
      errorTitle = 'Empty Title';
      errorDescription = 'A Task must have a title';
    } else if (priority == null || priority < 1) {
      errorTitle = 'Incorrect Priority';
      errorDescription =
          'A Task must have a priority, starting from 1 and above.\n Priority 1 is considered as highest priority';
    } else if (_category == null) {
      errorTitle = 'No Category';
      errorDescription = 'Please choose or add the category of the task';
    } else {
      isValid = true;
    }

    if (!isValid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: Text(errorTitle!),
          content: Text(errorDescription!),
          actions: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                },
                child: const Text('Okay'))
          ],
        ),
      );
      return;
    }
    final newTask = Task(
        title: _titleController.text,
        description: _descriptionController.text,
        priority: priority!,
        categoryId: _category!.id,
        assignedDate: _assignedTime,
        dueDate: _dueTime,
        isDone: false);
    widget._addOrEditTask(newTask);
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.editTitle ?? '';
    _descriptionController.text = widget.editDescription ?? '';
    _priorityControlloer.text = (widget.editPriority ?? 1).toString();
    _category = widget.editcategory;
    _assignedTime = widget.editAssignedDate ?? DateTime.now();
    _dueTime =
    widget.editDueDate ?? DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityControlloer.dispose();
    if (_addCatergoryController != null) {
      _addCatergoryController!.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _allcategory.sort((ctg1, ctg2) =>
        ctg1.category.toUpperCase().compareTo(ctg2.category.toUpperCase()));
    
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
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  label: Text(
                    'Title',
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  hintText: 'Title of your task',
                ),
              ),
              TextField(
                controller: _descriptionController,
                minLines: 1,
                maxLines: 4,
                style: Theme.of(context).textTheme.bodyMedium,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: Theme.of(context).textTheme.labelLarge,
                  hintText: 'Detail of task',
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const SizedBox(width: 5),
                  Column(
                    children: [
                      Text('Caterory: ',
                          textAlign: TextAlign.start,
                          style: Theme.of(context).textTheme.labelLarge),
                      DropdownButton(
                        value: _category == null ? null : _category!.id,
                        menuMaxHeight: 200,
                        items: [
                          DropdownMenuItem(
                            value: ' ',
                            child: TextButton(
                              onPressed: () {
                                setState(() {
                                  Navigator.pop(context);
                                  addCategoryDialog();
                                });
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.add),
                                  Text('   Add Category'),
                                ],
                              ),
                            ),
                          ),
                          ..._allcategory.map((category) {
                            return DropdownMenuItem(
                              value: category.id,
                              child: Text(
                                category.category.toUpperCase(),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            );
                          }),
                          DropdownMenuItem(
                            value: '  ',
                            child: TextButton(
                              onPressed: _allcategory.isNotEmpty
                                  ? manageCategoryDialog
                                  : null,
                              child: const Row(
                                children: [
                                  Icon(Icons.settings),
                                  Text('    Manage'),
                                ],
                              ),
                            ),
                          ),
                        ],
                        onChanged: (value) {
                          if (value is int) {
                            setState(() {
                              _category = categoryBox.get(value);
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(width: 70),
                  Expanded(
                    child: TextField(
                      controller: _priorityControlloer,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'Priority',
                        labelStyle: Theme.of(context).textTheme.labelLarge,
                        helperText: '1 is highest priority',
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Assigned on: ',
                            style: Theme.of(context).textTheme.labelLarge),
                        TextSpan(
                            text: formattedDate(_assignedTime),
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: getAssignedDateTime,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text: 'Due on: ',
                            style: Theme.of(context).textTheme.labelLarge),
                        TextSpan(
                            text: formattedDate(_dueTime),
                            style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  IconButton(
                    onPressed: getDueDateTime,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  FilledButton(
                    onPressed: saveTask,
                    child: const Text('Save Task'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
