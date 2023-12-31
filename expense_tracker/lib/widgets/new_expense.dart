import 'package:flutter/material.dart';
import 'package:expense_tracker/models/expense.dart';

// ignore: must_be_immutable
class NewExpense extends StatefulWidget {
  NewExpense(this.addNewExpense, {super.key});

  void Function(Expense) addNewExpense;

  @override
  State<NewExpense> createState() {
    return _NewExpense();
  }
}

class _NewExpense extends State<NewExpense> {
  final _titleController = TextEditingController();
  final _amtController = TextEditingController();
  DateTime _selectedDate= DateTime.now();
  Category _selectedCategory = Category.work;

  @override
  void dispose() {
    _titleController.dispose();
    _amtController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 1, now.month, now.day);
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: firstDate,
      lastDate: now,
    );
    setState(() {
      _selectedDate = pickedDate??DateTime.now();
    });
  }

  void _submitExpense() {
    final amt = double.tryParse(_amtController.text);
    final isValidAmt = amt == null || amt <= 0;
    if (_titleController.text.trim().isEmpty ||
        isValidAmt ) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid Expense'),
          content: const Text(
              'Please enter a valid title, amount and category'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
              },
              child: const Text('Okay'),
            )
          ],
        ),
      );
      return;
    }
    final newExp = Expense(
      title: _titleController.text,
      amount: amt,
      date: _selectedDate,
      dbCategory: _selectedCategory.index,
    );
    widget.addNewExpense(newExp);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace= MediaQuery.of(context).viewInsets.bottom;

    return SizedBox(
      height: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16,16,16,keyboardSpace+16),
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                keyboardType: TextInputType.text,
                maxLength: 50,
                decoration: InputDecoration(label: Text('Title',style: Theme.of(context).textTheme.titleLarge),),
                style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amtController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        label: Text('Amount',style: Theme.of(context).textTheme.titleLarge),
                        prefixText: '₹ ',
                        prefixStyle:Theme.of(context).textTheme.titleLarge,
                      ),
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
                    ),
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text( formatter.format(_selectedDate),
                          style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
                        ),
                        IconButton(
                          onPressed: _presentDatePicker,
                          icon: const Icon(
                            Icons.calendar_month,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              Row(
                children: [
                  DropdownButton(
                    value: _selectedCategory,
                    items: Category.values
                        .map(
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category.name.toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.normal),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedCategory = value;
                      });
                    },
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                      onPressed: _submitExpense, child: const Text('Save Expense'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
