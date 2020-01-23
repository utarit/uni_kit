import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';

class CourseEditScreen extends StatefulWidget {
  final Course course;
  CourseEditScreen({this.course});

  @override
  _CourseEditScreenState createState() => _CourseEditScreenState();
}

class _CourseEditScreenState extends State<CourseEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final courseAcronymController = TextEditingController();
  final courseNameController = TextEditingController();
  List<TextEditingController> syllabusControllerList;
  List<CourseTime> lessonHours;
  int _selectedColor = 0;


  @override
  void initState() {
    super.initState();
    lessonHours = List<CourseTime>();
    syllabusControllerList = List<TextEditingController>();

    if (widget.course != null) {
      for (int i = 0; i < widget.course.hours.length; i++) {
        lessonHours.add(widget.course.hours[i]);
      }
      for (int i = 0; i < 14; i++) {
        syllabusControllerList
            .add(TextEditingController(text: widget.course?.syllabus[i] ?? ""));
      }
      for (int i = 0; i < colorPalette.length; i++) {
        if (widget.course.color == colorPalette[i]) {
          setState(() {
            _selectedColor = i;
          });
        }
      }
      courseAcronymController.text = widget.course.acronym;
      courseNameController.text = widget.course.fullName;
    } else {
      for (int i = 0; i < 14; i++) {
        syllabusControllerList.add(TextEditingController());
      }
    }
    // _openHiveBox();
  }

  // _openHiveBox() async {
  //   await Hive.openBox("courses");
  //   setState(() {
  //     loaded = true;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "${widget.course == null ? "Add" : "Edit"} Course",
          style: TextStyle(
            fontFamily: "Galano",
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              _submitCourse();
            },
          ),
          SizedBox(
            width: 4,
          )
        ],
      ),
      body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: widget.course == null
                        ? TextFormField(
                            controller: courseAcronymController,
                            textCapitalization: TextCapitalization.characters,
                            decoration: InputDecoration(
                              labelText: "Enter Course Acronym",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: BorderSide(),
                              ),
                              //fillColor: Colors.green
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Please enter some text';
                              } else if (value.length > 7) {
                                return 'Acronym cannot be longer that 7 character';
                              }
                              // else if (await Provider.of<CourseProvider>(context, listen: false).isThereSameCourse(value)) {
                              //   return "This course is already in your program";
                              // }
                              return null;
                            },
                          )
                        : Text(
                            widget.course.acronym,
                            style: TextStyle(
                              fontFamily: "Galano",
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                  ),
                  SizedBox(
                    height: 75,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: colorPalette.length,
                      itemBuilder: (context, index) {
                        return FlatButton(
                          padding: EdgeInsets.all(0),
                          onPressed: () {
                            setState(() {
                              _selectedColor = index;
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.all(8),
                            width: 75,
                            decoration: BoxDecoration(
                              border: _selectedColor == index
                                  ? Border.all(color: Colors.black, width: 2)
                                  : Border.all(width: 0),
                              borderRadius: BorderRadius.circular(12),
                              color: Color(colorPalette[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: courseNameController,
                      textCapitalization: TextCapitalization.words,
                      decoration: new InputDecoration(
                        labelText: "Enter Course Name",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                          borderSide: new BorderSide(),
                        ),
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        } else if (value.length > 30) {
                          return 'No more than 30 characters';
                        }
                        return null;
                      },
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 16, bottom: 8),
                    child: Text(
                      "Course Hours",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildHourSelectionTable(context),
                  // RaisedButton(
                  //   child: Text("Add Lesson Hour"),
                  //   onPressed: () {
                  //     _showBottomSheet(context);
                  //   },
                  // ),
                  SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Syllabus",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Column(
                    children: List.generate(14, (index) {
                      return TextFormField(
                        // initialValue: "-",
                        controller: syllabusControllerList[index],
                        decoration: InputDecoration(
                            labelText: 'Enter Week ${index + 1}'),
                        validator: (value) {
                          if (value.length > 30) {
                            return 'No more than 30 characters';
                          }
                          return null;
                        },
                      );
                    }),
                  ),
                ],
              ),
            ),
          )),
    );
  }

  void _submitCourse() async {
    if (_formKey.currentState.validate()) {
      Course result = Course(
          acronym: courseAcronymController.text.toUpperCase(),
          fullName: courseNameController.text,
          hours: lessonHours,
          //key: widget.course?.key ?? DateTime.now().millisecondsSinceEpoch % UPPER_LIMIT,
          color: colorPalette[_selectedColor],
          syllabus: syllabusControllerList
              .map((f) => f.text.isEmpty ? "-" : f.text)
              .toList());

      Provider.of<CourseProvider>(context, listen: false)
          .editCourse(result.acronym, result);
      // await Hive.openBox("courses");
      // Hive.box("courses").put(result.acronym, result);
      Navigator.pop(context);
      if (widget.course != null) {
        Navigator.pop(context);
      }
    }
  }

  Widget _buildHourSelectionTable(context) {
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

      // program = Program.empty();
      // for (int i = 0; i < courses.length; i++) {
      //   final course = courses.getAt(i) as Course;
      //   program.addCourse(course);
      // }

      for (int i = 0; i < 5; i++) {
        row.children.add(GestureDetector(
          onTap: () {
            setState(() {
              final hourIndex = _hourIndex(hour, i + 1);
              if (hourIndex >= 0) {
                lessonHours.removeAt(hourIndex);
              } else {
                lessonHours.add(CourseTime(day: i + 1, hour: hour));
              }
            });
          },
          child: _hourIndex(hour, i + 1) < 0
              ? Container(
                  child: Icon(Icons.add, color: Colors.blue),
                  color: Colors.transparent,
                )
              : Container(
                  child: Icon(Icons.check, color: Colors.white),
                  color: Colors.greenAccent,
                ),
        ));
      }
      programList.add(row);
    }

    return Table(
      children: programList,
    );
  }

  int _hourIndex(int hour, int day) {
    for (int i = 0; i < lessonHours.length; i++) {
      if (lessonHours[i].hour == hour && lessonHours[i].day == day) {
        return i;
      }
    }

    return -1;
  }
}
