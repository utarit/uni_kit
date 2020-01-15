import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';
import 'package:uni_kit/features/todo_list/ui/screens/deadline_edit_screen.dart';
import 'package:uni_kit/features/todo_list/ui/widgets/todo_list_tile.dart';

class DeadlineScreen extends StatelessWidget {
  final Map<String, Color> colorList = {
    "lastDay": Colors.red,
    "lastWeek": Colors.orange,
    "others": Colors.green,
    "passed": Colors.grey
  };

  @override
  Widget build(BuildContext context) {
    print("Deadline Screen built");

    return Row(
      // mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          //color: Color(0xFFE2E6EE),
          width: MediaQuery.of(context).size.width * 4 / 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 45.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "TODOs",
                      style: TextStyle(
                          fontFamily: "Galano",
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add),
                      onPressed: () {
                        _navigateDeadlineEditScreen(context);
                      },
                    )
                  ],
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 8.0),
              //   child: Text("You can swipe to delete",
              //       style: TextStyle(color: Colors.black38)),
              // ),
              Expanded(
                child: Selector<TodoProvider, List<Deadline>>(
                  selector: (context, TodoProvider todoProvider) =>
                      todoProvider.deadlines,
                  builder: (context, List<Deadline> deadlines, child) =>
                      buildListView(deadlines),
                ),
              )
            ],
          ),
        ),
        Container(
          color: Color(0xFF232429),
          width: MediaQuery.of(context).size.width * 1 / 5,
          child: Selector<CourseProvider, List<Course>>(
            selector: (context, CourseProvider courseProvider) =>
                courseProvider.courses,
            builder: (context, List<Course> courses, child) => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // Padding(
                //   padding: const EdgeInsets.only(top: 32.0),
                //   child: Icon(
                //     Icons.sort,
                //     color: Colors.white,
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: buildCourseList(context, courses),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Icon(
                    Icons.calendar_today,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget buildCourseList(context, List<Course> courses) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: List.generate(courses.length, (index) {
          return Container(
              height: MediaQuery.of(context).size.width * 1 / 5 - 30,
              width: MediaQuery.of(context).size.width * 1 / 5 - 30,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Color(0xff3A3B40),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [BoxShadow(offset: Offset.fromDirection(3.14 / 2))]
                  // border: Border.all(color: Colors.grey),
                  ),
              alignment: Alignment.center,
              child: Text(
                courses[index].acronym[0],
                style: TextStyle(
                    fontSize: 20,
                    color: Color(courses[index].color),
                    fontWeight: FontWeight.bold),
              ));
        }));
  }

  ListView buildListView(List<Deadline> deadlines) {
    var sorted = sortedDeadlines(deadlines);

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final deadline = sorted[index];

        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            Provider.of<TodoProvider>(context, listen: false)
                .deleteDeadline(deadline.key);
          },
          background: Container(
            padding: EdgeInsets.only(right: 16),
            alignment: Alignment.centerRight,
            color: Colors.redAccent[400],
            child: Icon(Icons.delete, color: Colors.white),
          ),
          key: UniqueKey(),
          child: TodoListTile(deadline),
        );
      },
    );
  }

  chooseTileColor(DateTime deadline) {
    final now = DateTime.now();
    if (deadline.isBefore(now)) {
      return Colors.grey;
    } else if (deadline.difference(now) < Duration(days: 1)) {
      return Colors.red;
    } else if (deadline.difference(now) < Duration(days: 7)) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  List<Deadline> sortedDeadlines(List<Deadline> deadlines) {
    deadlines.sort((a, b) => a.endTime.compareTo(b.endTime));
    return deadlines;
  }

  _navigateDeadlineEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeadlineEditScreen()),
    );
  }
}
