import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();
enum Category { food,travel, leisure, work }
final formatter = DateFormat.yMd();
const categoryIcons={
  Category.food:Icons.lunch_dining,
  Category.travel:Icons.train,
  Category.leisure:Icons.movie,
  Category.work:Icons.book,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }): id = uuid.v4();

  String get formattedDate{
    return formatter.format(date);
  }
}
