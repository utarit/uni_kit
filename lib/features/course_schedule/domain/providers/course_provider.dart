import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';

class CourseProvider extends ChangeNotifier {
  static const courseBoxName = "courses";
  List<Course> courses = [];

  void getCourses() async {
    var box = await Hive.openBox<Course>(courseBoxName);

    // Update our provider state data with a hive read, and refresh the ui
    courses = box.values.toList();
    closeBox();
    notifyListeners();
  }

  Course getCourse(index) {
    return courses[index];
  }

  Future<bool> isThereSameCourse(String acronym) async {
    var box = await Hive.openBox<Course>(courseBoxName);
    bool result = box.containsKey(acronym.toUpperCase());
    closeBox();
    return result;
  }

  void deleteCourse(key) async {
    var box = await Hive.openBox<Course>(courseBoxName);

    await box.delete(key);

    // Update _contacts List with all box values
    courses = box.values.toList();

    print("Deleted contact with key: " + key.toString());
    closeBox();
    // Update UI
    notifyListeners();
  }

  void editCourse(String courseAcronym, Course course) async {
    var box = await Hive.openBox<Course>(courseBoxName);

    // Add a contact to our box
    await box.put(courseAcronym, course);

    // Update _contacts List with all box values
    courses = box.values.toList();

    closeBox();
    print('New Name Of Course: ' + course.acronym);

    // Update UI
    notifyListeners();
  }

  void closeBox() {
    Hive.close();
  }
}
