import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:score_counter/modal/game.dart';
import 'package:score_counter/objectbox.g.dart'; // created by `flutter pub run build_runner build`


late final Query<Player> getPlayers;

class ObjectBox {
  /// The Store of this app.
  late final Store store;
  
  ObjectBox._create(this.store) {
    // Add any additional setup code, e.g. build queries.
    getPlayers=store.box<Player>().query(Player_.gameId.equals(0)).build();
  }

  /// Create an instance of ObjectBox to use throughout the app.
  static Future<ObjectBox> create() async {
    final docsDir = await getApplicationDocumentsDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    final store = await openStore(directory: p.join(docsDir.path, "obx-example"));
    return ObjectBox._create(store);
  }
}