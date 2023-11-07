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
    setState(() {
      _regiesteredExpenses.remove(exp);
    });
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
    Widget Content = Center(
      child: Column(
        children: [
          Opacity(
            opacity: 0.6,
            child: Image.asset(
              'assests/images/noExpenses.png',
              // scale: 300,
            ),
          ),
          const Text(
            'No Expenses found',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 97, 96, 96)
            ),
          ),
          const Text('Start tracking your Expenses, NOW !,',
          style: TextStyle(fontSize: 20),),
        ],
      ),
    );

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
          (_regiesteredExpenses.isEmpty)
              ? Content
              : Expanded(
                  child: ExpensesList(
                  expenses: _regiesteredExpenses,
                  onRemovedExpense: _removeExpense,
                )),
        ],
      ),
    );
  }
}
