import 'package:flutter/material.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';

class NewEditTask extends StatefulWidget {
  NewEditTask(this._addOrEditTask, {super.key});

  final void Function(Task) _addOrEditTask;

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
  DateTime _assignedTime = DateTime.now();
  DateTime _dueTime = DateTime.now().add(const Duration(days: 1));
  Category? _category;
  final List<Category> _allcategory = categoryBox.getAll();

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
    final pickedTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    setState(() {
      _dueTime = pickedTime ?? DateTime.now();
    });
  }

  void addCategory() {
    if (_addCatergoryController!.text.isEmpty) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('Category Name not found'),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('Okay'))
                ],
              ));
    }
    final newCategory = Category(_addCatergoryController!.text);
    categoryBox.put(newCategory);
    setState(() {
      _allcategory.add(newCategory);
    });
  }

  void addCategoryDialog() {
    _addCatergoryController = TextEditingController();
    showDialog(
        context: context,
        builder: (ctx) {
          return Dialog(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Add Catergory'),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _addCatergoryController,
                    maxLength: 15,
                    decoration: const InputDecoration(
                        labelText: 'Name', hintText: 'generally a word'),
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
                      TextButton(onPressed: () {}, child: const Text('Manage')),
                      ElevatedButton(
                        onPressed: () {
                          addCategory();
                          Navigator.pop(ctx);
                        },
                        child: const Text('Save'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }

  void saveTask() {
    bool isValid = false;
    String? errorTitle;
    String? errorDescription;
    int? priority = int.tryParse(_priorityControlloer.text);

    if (_titleController.text.isEmpty) {
      errorTitle = 'Empty Title';
      errorDescription = 'A Task must have a title';
    } else if (priority == null || priority >= 1) {
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
              ));
      return;
    }
    final newTask = Task(
        title: _titleController.text,
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
    _titleController.text = 'homework';
    _descriptionController.text =
        'description.............................////////////...................................................................................................................';
    _priorityControlloer.text = '1';
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityControlloer.dispose();
    _addCatergoryController ?? _addCatergoryController!.dispose();
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
                      const Text(
                        'Caterory: ',
                        textAlign: TextAlign.start,
                      ),
                      //SizedBox(height: 10),
                      DropdownButton(
                        value: _category,
                        items: [
                          ..._allcategory.map((category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Text(category.category.toUpperCase()));
                          }),
                          DropdownMenuItem(
                            value: ' ',
                            child: TextButton(
                              onPressed: addCategoryDialog,
                              child: const Row(
                                children: [
                                  Icon(Icons.add),
                                  Text('Add Category'),
                                ],
                              ),
                            ),
                          ),
                        ],
                        // const [
                        //   DropdownMenuItem(
                        //     value: 1,
                        //     child: Text('Category1'),
                        //   ),
                        //   DropdownMenuItem(
                        //     value: 2,
                        //     child: Text('Category2'),
                        //   ),
                        // ],
                        onChanged: (value) {
                          if (value is Category) {
                            setState(() {
                              _category = value;
                            });
                          }
                        },
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
                  Text('Assigned on: ${formattedDate(_assignedTime)}'),
                  IconButton(
                    onPressed: getAssignedDateTime,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Text('Due on: ${formattedDate(_dueTime)}'),
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
