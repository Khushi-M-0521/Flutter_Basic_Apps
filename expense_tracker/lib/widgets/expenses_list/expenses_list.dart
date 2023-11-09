import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/expenses_list/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList(
      {super.key, required this.expenses, required this.onRemovedExpense});

  final List<Expense> expenses;
  final void Function(Expense) onRemovedExpense;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, index) => Dismissible(
          background: Container(
            
            color: Theme.of(context).colorScheme.error.withOpacity(0.9),
            margin: EdgeInsets.symmetric(
                horizontal: Theme.of(context).cardTheme.margin!.horizontal-10),
            child: const Row(
              children: [
                SizedBox(width: 15,),
                Icon(Icons.delete,size: 30,),
                Spacer(),
                Icon(Icons.delete,size: 30,),
                SizedBox(width: 15,),
              ],
            ),
          ),
          onDismissed: (direction) {
            onRemovedExpense(expenses[index]);
          },
          key: ValueKey(expenses[index]),
          child: ExpenseItem(expenses[index])),
    );
  }
}
