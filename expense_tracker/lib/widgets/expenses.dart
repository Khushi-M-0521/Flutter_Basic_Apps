import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}




class _ExpensesState extends State<Expenses> {
  final List<Expense> _regiesteredExpenses = [
    Expense(
      title: 'Flutter course',
      amount: 449.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 600,
      date: DateTime.now(),
      category: Category.leisure,
    )
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(context: context, builder: (ctx)=> const NewExpense());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
        title: const Text('Your Expense Tracker'),
      ),
      body: Column(
        children: [
          const Text('the chart'),
          Expanded(child: ExpensesList(expenses: _regiesteredExpenses)),
        ],
      ),
    );
  }
}
