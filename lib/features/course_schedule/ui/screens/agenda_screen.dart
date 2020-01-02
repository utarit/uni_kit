import 'package:flutter/material.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/course_edit_screen.dart';
import 'package:uni_kit/features/course_schedule/ui/widgets/course_list_widget.dart';
import 'package:uni_kit/features/course_schedule/ui/widgets/schedule_widget.dart';

class AgendaScreen extends StatelessWidget {
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
  Widget build(BuildContext context) {
    print("Agenda Screen Built");
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding:
              const EdgeInsets.only(left: 10, right: 10, top: 45.0, bottom: 8),
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
        CourseScheduleWidget(),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 12.0),
          child: Text("Course List",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: CourseListWidget(),
        )
      ],
    );
  }
}
