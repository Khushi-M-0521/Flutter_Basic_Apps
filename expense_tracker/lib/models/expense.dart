import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.travel: Icons.train,
  Category.leisure: Icons.movie,
  Category.work: Icons.book,
};

@Entity()
class Expense {
  @Id()
  int id=0;
  final String title;
  final double amount;
  final int dbCategory;

  @Property(type: PropertyType.date)
  final DateTime date;

  @Transient()
  Category category;

  
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.dbCategory,
  }):category=Category.values[dbCategory];

  
  @Transient()
  String get formattedDate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allExpenses, this.category)
      : expenses = allExpenses.where((exp) => exp.category==category).toList(); //alternative constructer function
  final Category category;
  final List<Expense> expenses;

  double get totalExpenses {
    double sum = 0;

    for (final expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
