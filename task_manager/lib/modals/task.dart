import 'package:objectbox/objectbox.dart';
import 'package:task_manager/data/store.dart';
import 'package:task_manager/modals/category.dart';

@Entity()
class Task{
  @Id()
  int id=0;
  String title;
  String? description;
  int priority;
  int categoryId;
  bool isDone; 

  @Property(type: PropertyType.date)
  DateTime assignedDate;
  
  @Property(type: PropertyType.date)
  DateTime dueDate;

  @Transient()
  Category get category {
    return categoryBox.get(categoryId)!;
  }
  
  Task({
    required this.title,
    this.description,
    required this.priority,
    required this.categoryId,
    required this.assignedDate,
    required this.dueDate,
    required this.isDone,
  });
}