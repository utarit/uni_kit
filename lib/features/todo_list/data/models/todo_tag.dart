import 'package:hive/hive.dart';

part 'todo_tag.g.dart';

@HiveType()
class TodoTag {
  @HiveField(0)
  String label;

  @HiveField(1)
  int colorValue;

  TodoTag(this.label, this.colorValue);

  @override
  String toString() {
    return label;
  }

  bool operator==(rhs) => rhs is TodoTag && label == rhs.label;
  int get hashCode => hashCode;
}
