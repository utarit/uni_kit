import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/models/course.dart';
import 'package:uni_kit/models/deadline.dart';
import 'package:uni_kit/screens/course_edit_screen.dart';
import 'package:uni_kit/utils/common_functions.dart';

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
    Hive.close();
    super.dispose();
  }

  void _showDialog() async {
    final coursesBox = await Hive.openBox("courses");
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
                for (int i = 0; i < coursesBox.length; i++) {
                  final hiveCourse = coursesBox.getAt(i) as Course;
                  if (widget.course.acronym == hiveCourse.acronym) {
                    coursesBox.deleteAt(i);
                  }
                }
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _editButton(){
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
        body: FutureBuilder(
            future: Hive.openBox("deadlines"),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  !snapshot.hasError) {
                return SingleChildScrollView(
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
                            // // print(widget.course.hours);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15.0),
                                child: Container(
                                    //margin: EdgeInsets.all(8.0),
                                    padding: EdgeInsets.all(12.0),
                                    color: Colors.pink[600],
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                        child:
                            Text("Deadlines", style: TextStyle(fontSize: 20)),
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
                );
              }

              return Container();
            }));
  }

  List<Widget> buildList() {
    final deadlinesBox = Hive.box("deadlines");
    List<Widget> widgetList = [];
    for (int i = 0; i < deadlinesBox.length; i++) {
      final deadline = deadlinesBox.getAt(i) as Deadline;
      var t = deadline.endTime;
      if (deadline.course.acronym.toUpperCase() ==
          widget.course.acronym.toUpperCase()) {
        widgetList.add(ListTile(
          title: Text(deadline.course.acronym),
          subtitle: Text(deadline.description),
          trailing: Text(
              "${formattedNum(t.day)}/${formattedNum(t.month)} ${formattedNum(t.hour)}:${formattedNum(t.minute)}"),
        ));
      }
    }
    return widgetList;
  }
}
