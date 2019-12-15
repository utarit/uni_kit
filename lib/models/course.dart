import 'package:hive/hive.dart';

part 'course.g.dart';

@HiveType()
class Course {
  @HiveField(0)
  String acronym;
  @HiveField(1)
  String fullName;
  @HiveField(2)
  List<CourseTime> hours;
  @HiveField(3)
  List<String> syllabus;
  @HiveField(4)
  int key;
  @HiveField(5)
  int color;

  Course({this.acronym, this.fullName, this.hours, this.syllabus, this.color, this.key});
}

@HiveType()
class CourseTime {
  @HiveField(0)
  int hour;
  @HiveField(1)
  int day;

  CourseTime({this.day, this.hour});
  @override
  String toString() {
    return "Day: $day / Hour: $hour";
  }
}
