import 'package:flutter/material.dart';
import 'package:task_manager/data/store.dart';
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
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Tasks on:   ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: formattedDate(tasksOn),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: 2,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Tasks from:   ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: formattedDate(tasksFrom),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: 3,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Due tasks on:   ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: formattedDate(dueTasksOn),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            DropdownMenuItem(
              value: 4,
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                        text: 'Due tasks till:   ',
                        style: Theme.of(context).textTheme.bodyLarge),
                    TextSpan(
                        text: formattedDate(dueTasksTill),
                        style: Theme.of(context).textTheme.bodyMedium),
                  ],
                ),
              ),
            ),
            const DropdownMenuItem(
              value: 5,
              child: Text('Delayed tasks'),
            ),
            DropdownMenuItem(
              value: 6,
              child: Row(
                children: [
                  const Text('Caterogized as:  '),
                  DropdownButton(
                    value: category == null ? _allcategory[0].id : category!.id,
                    items: _allcategory
                        .map((ctg) => DropdownMenuItem(
                            value: ctg.id, child: Text(ctg.category.toUpperCase(),style: Theme.of(context).textTheme.bodyMedium,)))
                        .toList(),
                    onChanged: (ctgId) {
                      setCategory(ctgId);
                    },
                  ),
                ],
              ),
            ),
          ],
          onChanged: (fltId) {
            setFilter(fltId);
          },
        ),
        IconButton(
            disabledColor: const Color.fromARGB(0, 255, 255, 255),
            onPressed: (filterId == 0 || filterId == 5 || filterId == 6)
                ? null
                : () {
                    if (filterId == 1) {
                      pickedDate(
                        initialDate: tasksOn,
                        who: 1,
                      );
                      return;
                    }
                    if (filterId == 2) {
                      pickedDate(
                        initialDate: tasksFrom,
                        who: 2,
                      );
                      return;
                    }
                    if (filterId == 3) {
                      pickedDate(
                        initialDate: dueTasksOn,
                        who: 3,
                      );
                      return;
                    }
                    if (filterId == 4) {
                      pickedDate(
                        initialDate: dueTasksTill,
                        who: 4,
                      );
                      return;
                    }
                  },
            icon: calender),
      ],
    );
  }
}
