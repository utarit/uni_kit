import 'package:uni_kit/features/course_schedule/data/models/course.dart';


class Program {
  List<List<Course>> data;
  Program.empty(){
    data = [];
    
    for(int i = 0; i < 9; i++){
      List<Course> tmp = [null, null, null, null, null];
      data.add(tmp);
    }
  }

  void addCourse(Course course){

    for(var lesson in course.hours){
      if(data[lesson.hour][lesson.day-1] == null)
        data[lesson.hour][lesson.day-1] = course;
    }
    
  }

  void removeCourse(Course course){
    for(var lesson in course.hours){
        data[lesson.hour][lesson.day-1] = null;
    }
  }

  Program refresh(List<Course> courses) {
    Program program = Program.empty();
    for(Course course in courses){
      addCourse(course);
    }
    return program;
  }

  void printTable(){
    for(var row in data){
      print(row);
    }
  }
}






