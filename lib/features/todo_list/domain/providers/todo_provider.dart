import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';

class TodoProvider extends ChangeNotifier {
  static const deadlineBoxName = "deadlines";


  List<Deadline> deadlines = [];

  void getDeadlines() async {
    var box = await Hive.openBox<Deadline>(deadlineBoxName);

    // Update our provider state data with a hive read, and refresh the ui
    deadlines = box.values.toList();
    closeBox();
    notifyListeners();
  }

  Deadline getDeadline(index) {
    return deadlines[index];
  }


  void deleteDeadline(key) async {
    var box = await Hive.openBox<Deadline>(deadlineBoxName);

    await box.delete(key);

    // Update _contacts List with all box values
    deadlines = box.values.toList();

    print("Deleted contact with key: " + key.toString());
    closeBox();
    // Update UI
    notifyListeners();
  }

  void editDeadline(int key, Deadline deadline) async {
    var box = await Hive.openBox<Deadline>(deadlineBoxName);

    // Add a contact to our box
    await box.put(key, deadline);

    // Update _contacts List with all box values
    deadlines = box.values.toList();

    closeBox();
    print('New Name Of Deadline: ' + deadline.key.toString());

    // Update UI
    notifyListeners();
  }

  void closeBox() {
    Hive.close();
  }
}
