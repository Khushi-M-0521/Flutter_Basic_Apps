import 'package:expense_tracker/widgets/chart/chart.dart';
import 'package:expense_tracker/widgets/expenses_list/expenses_list.dart';
import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/main.dart';


final expensebox=objectbox.store.box<Expense>() ;

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }
}

class _ExpensesState extends State<Expenses> {
  

  List<Expense> _regiesteredExpenses =[];


  @override
  void initState(){
    super.initState();
    _regiesteredExpenses =expensebox.getAll();
    _regiesteredExpenses==[]?_regiesteredExpenses:_regiesteredExpenses.sort(descendDate);

  }

  int descendDate(Expense exp1,Expense exp2){
    return exp1.date.isAtSameMomentAs(exp2.date)?0: 
            exp1.date.isAfter(exp2.date)?-1:1;
  }

  void addNewExpense(Expense exp) {
    setState(() {
      _regiesteredExpenses.add(exp);
      _regiesteredExpenses.sort(descendDate);
      expensebox.put(exp);
    });
  }

  void _removeExpense(Expense exp) {
    final expenseIndex = _regiesteredExpenses.indexOf(exp);
    setState(() {
      _regiesteredExpenses.remove(exp);
      expensebox.remove(exp.id);
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
                  expensebox.put(exp);
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
