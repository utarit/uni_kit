import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';
import 'package:uni_kit/features/todo_list/ui/screens/deadline_edit_screen.dart';
import 'package:uni_kit/features/todo_list/ui/widgets/todo_list_tile.dart';

class DeadlineScreen extends StatefulWidget {
  @override
  _DeadlineScreenState createState() => _DeadlineScreenState();
}

class _DeadlineScreenState extends State<DeadlineScreen> {
  String todoFilter = "";

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
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 1 / 5,
          child: Selector<CourseProvider, List<Course>>(
            selector: (context, CourseProvider courseProvider) =>
                courseProvider.courses,
            builder: (context, List<Course> courses, child) =>
                SingleChildScrollView(
              child: Column(
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
                    padding: const EdgeInsets.only(top: 34.0),
                    child: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  buildCourseTile(context, "ALL", Colors.white.value, ""),
                  buildCourseList(context, courses),
                  // buildCourseTile(context, "+", Colors.white.value, "+")
                ],
              ),
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
        return buildCourseTile(context, courses[index].acronym[0],
            courses[index].color, courses[index].acronym);
      }),
    );
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
            color: Colors.grey,
            child: Icon(Icons.delete, color: Colors.white),
          ),
          key: UniqueKey(),
          child: TodoListTile(deadline),
        );
      },
    );
  }

  Widget buildCourseTile(context, letter, color, filter) => GestureDetector(
        onTap: () {
          if (filter == "+") {
            //add
          } else {
            if (todoFilter != filter) {
              setState(() {
                todoFilter = filter;
              });
            }
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.width * 1 / 5 - 30,
              width: MediaQuery.of(context).size.width * 1 / 5 - 30,
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xff3A3B40),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(offset: Offset.fromDirection(3.14 / 2))],
                // border: Border.all(width: todoFilter == filter ? 1 : 0),
              ),
              alignment: Alignment.center,
              child: Text(
                letter,
                style: TextStyle(
                    fontSize: 20,
                    color: Color(color),
                    fontWeight: FontWeight.bold),
              ),
            ),
            todoFilter == filter
                ? Positioned(
                    right: 5,
                    top: 13,
                    child: CircleAvatar(
                      radius: 4,
                      child: Container(),
                      backgroundColor: Color(color),
                    ),
                  )
                : SizedBox.shrink()
          ],
        ),
      );

  List<Deadline> sortedDeadlines(List<Deadline> deadlines) {
    deadlines.sort((a, b) => a.endTime.compareTo(b.endTime));
    if (todoFilter != "") {
      return deadlines
          .where((entry) => entry.course.acronym == todoFilter)
          .toList();
    }
    return deadlines;
  }

  _navigateDeadlineEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeadlineEditScreen()),
    );
  }
}
