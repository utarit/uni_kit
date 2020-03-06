import 'package:hive/hive.dart';

class LocalDataProvider {
  static const boxName = "local";

  Future<String> getUserName() async {
    var box = await Hive.openBox<String>(boxName);
    String username;

    if (box.containsKey("username")) {
      username = box.get("username");
    }
    closeBox();

    return username;
  }

  void setUsername(String username) async {
    var box = await Hive.openBox<String>(boxName);

    if (box.containsKey("username")) {
      box.put("username", username);
    }
    closeBox();
  }

  Future<bool> isNewUser() async {
    var box = await Hive.openBox<String>(boxName);
    if (box.containsKey("isNew")) {
      closeBox();
      return false;
    }
    closeBox();
    return true;
  }

  void deleteUsername() async {
    var box = await Hive.openBox<String>(boxName);
    if (box.containsKey("username")) {
      box.delete("username");
    }
    closeBox();
  }

  void closeBox() {
    Hive.close();
  }
}
