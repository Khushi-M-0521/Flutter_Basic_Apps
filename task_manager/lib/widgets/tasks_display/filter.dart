import 'package:flutter/material.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/constants.dart';

class Filter extends StatelessWidget {
  Filter({
    super.key,
    required this.tasksOn,
    required this.tasksFrom,
    required this.dueTasksOn,
    required this.dueTasksTill,
    required this.category,
    required this.pickedDate,
    required this.setCategory,
    required this.filterId,
    required this.setFilter,
  });

  final DateTime tasksOn;
  final DateTime tasksFrom;
  final DateTime dueTasksOn;
  final DateTime dueTasksTill;
  final Category? category;
  final Future Function({required DateTime initialDate, required int who}) pickedDate;
  final void Function(int? ctgId) setCategory;
  final int filterId;
  final void Function(int? fltId) setFilter;
  final List<Category> _allcategory = categoryBox.getAll();

  @override
  Widget build(BuildContext context) {
    const calender = Icon(Icons.calendar_month);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.filter_list),
        const SizedBox(
          width: 20,
        ),
        DropdownButton(
          value: filterId,
          alignment: Alignment.center,
          items: [
            const DropdownMenuItem(
              value: 0,
              child: Text('All Tasks'),
            ),
            DropdownMenuItem(
              value: 1,
              child: Row(
                children: [
                  Text('Tasks on: ${formattedDate(tasksOn)}'),
                  IconButton(
                      onPressed: () {
                        pickedDate(
                          initialDate: tasksOn,
                          who: 1,
                        );
                        
                      },
                      icon: calender),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: Row(
                children: [
                  Text('Tasks from: ${formattedDate(tasksFrom)}'),
                  IconButton(
                      onPressed: () {
                        pickedDate(
                          initialDate: tasksFrom,
                          who: 2,
                        );
                      },
                      icon: calender),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 3,
              child: Row(
                children: [
                  Text('Due tasks on: ${formattedDate(dueTasksOn)}'),
                  IconButton(
                      onPressed: () {
                        pickedDate(
                          initialDate: dueTasksOn,
                          who: 3,
                        );
                      },
                      icon: calender),
                ],
              ),
            ),
            DropdownMenuItem(
              value: 4,
              child: Row(
                children: [
                  Text('Due tasks till: ${formattedDate(dueTasksTill)}'),
                  IconButton(
                      onPressed: () {
                        pickedDate(
                          initialDate: dueTasksTill,
                          who: 4,
                        );
                      },
                      icon: calender),
                ],
              ),
            ),
            const DropdownMenuItem(
              value: 5,
              child: Text('Delayed tasks: '),
            ),
            DropdownMenuItem(
              value: 6,
              child: Row(
                children: [
                  const Text('Caterogized as: '),
                  DropdownButton(
                      value: category==null?_allcategory[0].id : category!.id,
                      items: _allcategory.map((ctg) => DropdownMenuItem(
                              value: ctg.id, child: Text(ctg.category)))
                          .toList(),
                      onChanged: (ctgId){ setCategory(ctgId); }),
                ],
              ),
            ),
          ],
          onChanged: (fltId) { setFilter(fltId); },
        )
      ],
    );
  }
}
