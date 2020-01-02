import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/course_edit_screen.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';

class CourseScreen extends StatefulWidget {
  final Course course;
  CourseScreen({this.course});
  @override
  _CourseScreenState createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool showDeadlines = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _showDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text("Delete Course"),
          content: Text("Are you sure to delete the course?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "Yes",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                Provider.of<CourseProvider>(context, listen: false)
                    .deleteCourse(widget.course.acronym);
                Future.delayed(Duration(milliseconds: 100), () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  _editButton() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CourseEditScreen(
                course: widget.course,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 32, bottom: 4, left: 8),
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.course.acronym,
                    style: TextStyle(
                        fontFamily: "Galano",
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          //color: Colors.red,
                          size: 30,
                        ),
                        onPressed: _editButton,
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: () {
                          _showDialog();
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                widget.course.fullName,
                style: TextStyle(fontFamily: "Galano", fontSize: 25),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                itemCount: widget.course.hours.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  // print(widget.course.hours);
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                          //margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(12.0),
                          color: Colors.pink[600],
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                color: Colors.white,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "${days[widget.course.hours[index].day - 1].text} ${hours[widget.course.hours[index].hour].text}",
                                style: TextStyle(color: Colors.white),
                              )
                            ],
                          )),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Deadlines", style: TextStyle(fontSize: 20)),
            ),
            Column(
              children: buildList(),
            ),
            FlatButton(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Syllabus", style: TextStyle(fontSize: 18)),
                  AnimatedIcon(
                    icon: AnimatedIcons.menu_close,
                    progress: _controller,
                  ),
                ],
              ),
              onPressed: () {
                showDeadlines = !showDeadlines;
                if (showDeadlines) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              },
            ),
            SizeTransition(
              sizeFactor: _controller,
              //color: Colors.lightGreen,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: widget.course.syllabus
                        .map((f) => Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Text(capitalizeFirst(f),
                                  style: TextStyle(fontSize: 16)),
                            ))
                        .toList()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildList() {
    final deadlines = Provider.of<TodoProvider>(context)
        .deadlines
        .where((deadline) => deadline.course.acronym == widget.course.acronym)
        .toList();
    List<Widget> widgetList = deadlines
        .map((deadline) => ListTile(
              title: Text(deadline.course.acronym),
              subtitle: Text(deadline.description),
              trailing: Text(
                  "${formattedNum(deadline.endTime.day)}/${formattedNum(deadline.endTime.month)} ${formattedNum(deadline.endTime.hour)}:${formattedNum(deadline.endTime.minute)}"),
            ))
        .toList();

    return widgetList;
  }
}
