import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/models/course.dart';
import 'package:uni_kit/models/deadline.dart';
import 'package:uni_kit/models/program.dart';
import 'package:uni_kit/screens/course_edit_screen.dart';
import 'package:uni_kit/screens/course_screen.dart';
import 'package:uni_kit/utils/common_functions.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  Program program;
  //List<Course> courseList;
  List<Deadline> deadlines = [];

  List<TableRow> generateTable(Box<dynamic> courses) {
    List<TableRow> programList = [
      TableRow(
        decoration: BoxDecoration(
          color: Colors.red[900],
          //borderRadius: BorderRadius.vertical(top: Radius.circular(8.0)),
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
        final course = courses.getAt(i) as Course;
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

  @override
  void initState() {
    super.initState();
    program = Program.empty();
    // courseList = List<Course>();
    //generateTable();
  }

  _navigateEditScreen(BuildContext context) {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseEditScreen()),
    );

    // if (result != null) {
    //   Hive.box("courses").put(result.key, result);
    // }
  }
@override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Hive.openBox("courses"),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              !snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 45.0, bottom: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Agenda",
                        style: TextStyle(
                            fontFamily: "Galano",
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.add,
                          size: 30,
                        ),
                        onPressed: () {
                          _navigateEditScreen(context);
                        },
                      )
                    ],
                  ),
                ),
                Table(
                    columnWidths: {0: FlexColumnWidth(0.7)},
                    //defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    // border: TableBorder.all(),
                    children: generateTable(Hive.box("courses"))),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, top: 12.0),
                  child: Text("Course List",
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                ),
                Expanded(
                  child: buildListView(),
                )
              ],
            );
          }
          return Container();
        });
  }

  ListView buildListView() {
    final coursesBox = Hive.box("courses");

    return ListView.builder(
      itemCount: coursesBox.length,
      itemBuilder: (BuildContext context, int index) {
        final course = coursesBox.getAt(index) as Course;
        Duration duration = DateTime.now().difference(schoolStarted);
        int ind = (duration.inDays ~/ 7);
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CourseScreen(
                        course: course,
                      )),
            );
          },
          title: Padding(
            padding: const EdgeInsets.only(bottom: 4.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: Color(course.color),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(course.acronym,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15
                      )),
                ),
                SizedBox(width: 8,),
                Text(course.fullName)
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(ind < 14 ? "Week ${ind + 1}: ${course.syllabus[ind]}" : "Semester Ended"),
          ),
          trailing: Icon(
            Icons.info,
            color: Color(course.color),
          ),
        );
      },
    );
  }
}
