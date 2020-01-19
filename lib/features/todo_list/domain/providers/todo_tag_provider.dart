import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/features/todo_list/data/models/todo_tag.dart';

class TodoTagProvider extends ChangeNotifier {
  static const todoTagBoxName = "todotags";


  List<TodoTag> todoTags = [];

  Future<void> getTodoTags() async {
    var box = await Hive.openBox<TodoTag>(todoTagBoxName);

    // Update our provider state data with a hive read, and refresh the ui
    todoTags = box.values.toList();
    closeBox();
    notifyListeners();
  }

  TodoTag getTodoTag(index) {
    return todoTags[index];
  }


  Future<void> deleteTodoTag(key) async {
    var box = await Hive.openBox<TodoTag>(todoTagBoxName);

    await box.delete(key);

    // Update _contacts List with all box values
    todoTags = box.values.toList();

    print("Deleted contact with key: " + key.toString());
    closeBox();
    // Update UI
    notifyListeners();
  }
  

  void editTodoTag(String label, TodoTag todo) async {
    var box = await Hive.openBox<TodoTag>(todoTagBoxName);

    // Add a contact to our box
    await box.put(label, todo);

    // Update _contacts List with all box values
    todoTags = box.values.toList();

    closeBox();
    print('New Name Of Todo: ' + todo.label);

    // Update UI
    notifyListeners();
  }

  void closeBox() {
    Hive.close();
  }
}
