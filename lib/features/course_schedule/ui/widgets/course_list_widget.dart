import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/course_screen.dart';

class CourseListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Built Course List");
    var courses = Provider.of<CourseProvider>(context).courses;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(courses.length, (index) {
        final course = courses[index];
        Duration duration = DateTime.now().difference(schoolStarted);
        int ind = (duration.inDays ~/ 7);
        return ListTile(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  settings: RouteSettings(name: 'CourseScreen'),
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
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(course.acronym,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(course.fullName)
              ],
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Text(ind < 14
                ? "Week ${ind + 1}: ${course.syllabus[ind]}"
                : "Semester Ended"),
          ),
          trailing: Icon(
            Icons.info,
            color: Color(course.color),
          ),
        );
      }),
    );
  }
}
