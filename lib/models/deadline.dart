import 'package:hive/hive.dart';
import 'package:uni_kit/models/course.dart';

part 'deadline.g.dart';

@HiveType()
class Deadline {
  @HiveField(0)
  Course course;
  @HiveField(1)
  DateTime endTime;
  @HiveField(2)
  int key;
  @HiveField(3)
  String description;

  Deadline({this.course, this.endTime, this.key, this.description});
  @override
  String toString() {
    return "$endTime $description";
  }
}
