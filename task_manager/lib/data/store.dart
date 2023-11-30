import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:task_manager/modals/category.dart';
import 'package:task_manager/modals/task.dart';
import 'package:task_manager/objectbox.g.dart'; // created by `flutter pub run build_runner build`

late final Box<Task> taskBox;
late final Box<Category> categoryBox;
late final Query<Task> queryTasksOn;
late final Query<Task> queryTasksFrom;
late final Query<Task> queryDueTasksOn;
late final Query<Task> queryDueTasksTill;
late final Query<Task> queryDelayed;
late final Query<Task> queryCategory;

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  
  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    taskBox = store.box<Task>();
    categoryBox = store.box<Category>();
    queryTasksOn = taskBox.query(Task_.assignedDate.equals(DateTime.now().millisecondsSinceEpoch)).build();
    queryTasksFrom = taskBox.query(Task_.assignedDate.greaterOrEqual(DateTime.now().millisecondsSinceEpoch)).build();
    queryDueTasksOn = taskBox.query(Task_.dueDate.equals(DateTime.now().millisecondsSinceEpoch)).build();
    queryDueTasksTill = taskBox.query(Task_.dueDate.lessOrEqual(DateTime.now().millisecondsSinceEpoch)).build();
    queryDelayed = taskBox.query(Task_.dueDate.lessOrEqual(DateTime.now().millisecondsSinceEpoch).and(Task_.isDone.equals(false))).build();
    queryCategory = taskBox.query(Task_.categoryId.equals(0)).build();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }

}