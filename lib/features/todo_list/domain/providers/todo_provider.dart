import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';

class TodoProvider extends ChangeNotifier {
  static const todoBoxName = "todos";

  List<Todo> todos = [];

  void getTodos() async {
    var box = await Hive.openBox<Todo>(todoBoxName);

    // Update our provider state data with a hive read, and refresh the ui
    todos = box.values.toList();
    closeBox();
    notifyListeners();
  }

  Todo getTodo(index) {
    return todos[index];
  }

  void deleteTodo(key) async {
    var box = await Hive.openBox<Todo>(todoBoxName);

    await box.delete(key);

    // Update _contacts List with all box values
    todos = box.values.toList();

    print("Deleted contact with key: " + key.toString());
    closeBox();
    // Update UI
    notifyListeners();
  }

  void editTodo(int key, Todo todo) async {
    var box = await Hive.openBox<Todo>(todoBoxName);

    // Add a contact to our box
    await box.put(key, todo);

    // Update _contacts List with all box values
    todos = box.values.toList();

    closeBox();
    print('New Name Of Todo: ' + todo.key.toString());

    // Update UI
    notifyListeners();
  }

  void editTodoMultiple(List<Todo> todos) async {
    var box = await Hive.openBox<Todo>(todoBoxName);

    // Add a contact to our box
    todos.forEach((todo) async {
      await box.put(todo.key, todo);
    });

    // Update _contacts List with all box values
    todos = box.values.toList();

    closeBox();

    // Update UI
    notifyListeners();
  }

  void closeBox() {
    Hive.close();
  }
}
