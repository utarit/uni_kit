import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/models/course.dart';

class DeadlineEditScreen extends StatefulWidget {
  @override
  _DeadlineEditScreenState createState() => _DeadlineEditScreenState();
}

class _DeadlineEditScreenState extends State<DeadlineEditScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime deadline;
  final descriptionController = TextEditingController();
  var coursesBox;
  int _selectedCourseIndex;

  String fs(int n) => n < 9 ? "0$n" : "$n";
  String formattedDate(DateTime date) =>
      "${fs(date.day)}/${fs(date.month)} ${fs(date.hour)}:${fs(date.minute)}";

  @override
  void initState() {
    super.initState();
    deadline = DateTime.now();
    _getCourseData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    Hive.close();
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.done,
              color: Colors.black,
              size: 30,
            ),
            onPressed: () {
              // Validate returns true if the form is valid, or false
              // otherwise.
              if (_formKey.currentState.validate()) {
                Course course;
                if (_selectedCourseIndex != null) {
                  course = coursesBox.getAt(_selectedCourseIndex) as Course;
                }
                Map<String, dynamic> data = {
                  "course": course == null
                      ? Course(acronym: "OTHER")
                      : course,
                  "description": descriptionController.text,
                  "deadline": deadline
                };
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(context, data);
                });
              }
            },
          ),
          SizedBox(
            width: 4,
          )
        ],
        centerTitle: true,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(
            Icons.arrow_back,
            size: 30,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Add Deadline",
          style: TextStyle(
              fontFamily: "Galano",
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: coursesBox != null
          ? Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: coursesBox.length,
                          itemBuilder: (context, index) {
                            final course = coursesBox.getAt(index) as Course;
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _selectedCourseIndex = index;
                                  });
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15.0),
                                  child: Container(
                                      padding: EdgeInsets.all(12.0),
                                      color: index == _selectedCourseIndex
                                          ? Color(course.color)
                                          : Color(course.color).withOpacity(0.5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(
                                            Icons.assignment,
                                            color: Colors.white,
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "${course.acronym}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      )),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      TextFormField(
                        controller: descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                            labelText: 'Enter Deadline Description'),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Row(
                        children: <Widget>[
                          FlatButton(
                              onPressed: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime.utc(
                                        DateTime.now().year + 1,
                                        12,
                                        31,
                                        23,
                                        59), onConfirm: (date) {
                                  setState(() {
                                    deadline = date;
                                  });
                                }, currentTime: DateTime.now());
                              },
                              child: Text(
                                "Choose a deadline",
                                style: TextStyle(color: Colors.blue),
                              )),
                          Text(deadline == null ? "" : formattedDate(deadline))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  void _getCourseData() async {
    await Hive.openBox("courses");
    setState(() {
      coursesBox = Hive.box("courses");
    });
  }
}
