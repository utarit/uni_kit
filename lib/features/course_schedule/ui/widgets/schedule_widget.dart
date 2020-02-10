import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/course_schedule/data/models/program.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';

class CourseScheduleWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Table built");
    var courses = Provider.of<CourseProvider>(context).courses;

    return Table(
        columnWidths: {0: FlexColumnWidth(0.7)},
        children: generateTable(courses));
  }

  List<TableRow> generateTable(List<Course> courses) {
    // print(courses);
    Program program = Program.empty();
    List<TableRow> programList = [
      TableRow(
        decoration: BoxDecoration(
          color: Colors.red[900],
        ),
        children: ["X", "Mon", "Tue", "Wed", "Thur", "Fri"]
            .map((day) => Container(
                  decoration: BoxDecoration(
                      border: Border(
                          right: day == "X"
                              ? BorderSide(width: 1)
                              : BorderSide.none)),
                  padding: const EdgeInsets.symmetric(
                      vertical: 4.0, horizontal: 2.0),
                  child: Center(
                      child: Text(
                    day,
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  )),
                ))
            .toList(),
      )
    ];

    for (int hour = 0; hour < 9; hour++) {
      TableRow row = TableRow(
          decoration: BoxDecoration(
              color: hour % 2 == 0 ? Colors.white : Colors.lightBlue[100]),
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              alignment: Alignment.centerRight,
              decoration:
                  BoxDecoration(border: Border(right: BorderSide(width: 1))),
              child: Text("${hour + 8}:40"),
            )
          ]);

      program = Program.empty();
      for (int i = 0; i < courses.length; i++) {
        final course = courses[i];
        program.addCourse(course);
      }

      for (int i = 0; i < program.data[hour].length; i++) {
        Course f = program.data[hour][i];
        if (f != null) {
          row.children.add(Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(5),
            // margin: const EdgeInsets.symmetric(horizontal: 3.0, vertical: 1),
            decoration: BoxDecoration(
              color: Color(f.color ?? Colors.transparent),
              // borderRadius: BorderRadius.circular(5),
            ),
            child: Text(f.acronym,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ));
        } else {
          row.children.add(Container());
        }
      }
      programList.add(row);
    }
    return programList;
  }
}
