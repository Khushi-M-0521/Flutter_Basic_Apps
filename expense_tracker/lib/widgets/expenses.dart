import 'package:expense_tracker/widgets/chart/chart.dart';
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

  void addNewExpense(Expense exp) {
    setState(() {
      _regiesteredExpenses.add(exp);
    });
  }

  void _removeExpense(Expense exp) {
    final expenseIndex = _regiesteredExpenses.indexOf(exp);
    setState(() {
      _regiesteredExpenses.remove(exp);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: const Text('Expense deleted'),
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                setState(() {
                  _regiesteredExpenses.insert(expenseIndex, exp);
                });
              })),
    );
  }

  void _openAddExpenseOverlay() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => NewExpense(addNewExpense),
      useSafeArea: true,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Column(
      children: [
        Opacity(
          opacity: 0.6,
          child: Image.asset(
            'assests/images/noExpenses.png',
            // scale: 300,
          ),
        ),
        Text(
          'No expenses found.',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontSize: 30,
              ),
        ),
        Text(
          'Start tracking your Expenses, NOW !!,',
          style: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(fontWeight: FontWeight.normal, fontSize: 20),
        ),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: _openAddExpenseOverlay,
            icon: const Icon(Icons.add),
          )
        ],
        title: Text(
          'Budget Buddy',
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: Column(
        children: (_regiesteredExpenses.isEmpty)
            ? [content]
            : [
                Chart(_regiesteredExpenses),
                Expanded(
                  child: ExpensesList(
                    expenses: _regiesteredExpenses,
                    onRemovedExpense: _removeExpense,
                  ),
                ),
              ],
      ),
    );
  }
}
