import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/constants.dart';
import 'package:task_manager/modals/task.dart';

class NewEditTask extends StatefulWidget {
  const NewEditTask(
    this._addOrEditTask, 
    {
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
    DateTime? pickedTime = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if(pickedTime!=null){
    pickedTime=pickedTime.add(const Duration(hours: 23, minutes: 59,seconds: 59));
    }
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
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Add Catergory', style: Theme.of(context).textTheme.bodyLarge,),
                  const SizedBox(height: 15),
                  TextField(
                    controller: _addCatergoryController,
                    maxLength: 15,
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration(
                        labelText: 'Name', 
                        labelStyle: Theme.of(context).textTheme.labelLarge,
                        hintText: 'generally a word',),
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
              ));
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
    _titleController.text = widget.editTitle??'';
    _descriptionController.text =widget.editDescription??'';
    _priorityControlloer.text = (widget.editPriority??1).toString();
    _category=widget.editcategory;
    _assignedTime=widget.editAssignedDate??DateTime.now();
    _dueTime=widget.editDueDate?? DateTime.now().add(const Duration(days: 1));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _priorityControlloer.dispose();
    if(_addCatergoryController!=null){
      _addCatergoryController!.dispose();
    }
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
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration(
                  label: Text('Title',style: Theme.of(context).textTheme.labelLarge,),
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
                      Text(
                        'Caterory: ',
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.labelLarge
                      ),
                      //SizedBox(height: 10),
                      DropdownButton(
                        value: _category,
                        items: [
                          ..._allcategory.map((category) {
                            return DropdownMenuItem(
                                value: category,
                                child: Text(category.category.toUpperCase(),style: Theme.of(context).textTheme.bodyMedium));
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
                  Text.rich(TextSpan(
                    children: [
                      TextSpan(text: 'Assigned on: ',style: Theme.of(context).textTheme.labelLarge),
                      TextSpan(text: formattedDate(_assignedTime),style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),),
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
                        TextSpan(text:'Due on: ',style: Theme.of(context).textTheme.labelLarge),
                        TextSpan(text: formattedDate(_dueTime),style: Theme.of(context).textTheme.bodyMedium)
                      ],
                    ),),
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
