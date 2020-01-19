import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/features/todo_list/data/models/todo_tag.dart';

part "todo.g.dart";

@HiveType()
class Todo {
  @HiveField(0)
  List<TodoTag> tags;
  @HiveField(1)
  DateTime endTime;
  @HiveField(2)
  final int key;
  @HiveField(3)
  String description;

  Todo({this.tags, @required this.endTime, @required this.key, @required this.description});
  @override
  String toString() {
    return "$endTime $description";
  }
}
