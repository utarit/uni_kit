import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';

class DeadlineEditScreen extends StatefulWidget {
  @override
  _DeadlineEditScreenState createState() => _DeadlineEditScreenState();
}

class _DeadlineEditScreenState extends State<DeadlineEditScreen> {
  final _formKey = GlobalKey<FormState>();
  DateTime deadline;
  final descriptionController = TextEditingController();
  int _selectedCourseIndex;

  String fs(int n) => n < 9 ? "0$n" : "$n";
  String formattedDate(DateTime date) =>
      "${days[date.weekday]}, ${fs(date.day)} ${months[date.month]} ${date.year}";

  @override
  void initState() {
    super.initState();
    deadline = DateTime.now();
    _selectedCourseIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    var deadlineProvider = Provider.of<TodoProvider>(context, listen: false);
    var courses = Provider.of<CourseProvider>(context, listen: false).courses;

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
                int key = DateTime.now().millisecondsSinceEpoch % UPPER_LIMIT;
                Deadline result = Deadline(
                    course: courses[_selectedCourseIndex] ??
                        Course(acronym: "OTHER"),
                    description: descriptionController.text,
                    endTime: deadline,
                    key: key);
                deadlineProvider.editDeadline(key, result);
                Future.delayed(const Duration(milliseconds: 100), () {
                  Navigator.pop(context);
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
          "Add ToDo",
          style: TextStyle(
              fontFamily: "Galano",
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black),
        ),
      ),
      body: courses != null
          ? Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      buildCourseList(context, courses),
                      SizedBox(
                        height: 16.0,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        controller: descriptionController,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          labelText: "Enter ToDo Description",
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
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 16.0),
                        child: RaisedButton(
                          child: Container(
                            child: Text("Set Time"),
                          ),
                          onPressed: () {
                                DatePicker.showDateTimePicker(context,
                                    showTitleActions: true,
                                    minTime: DateTime.now(),
                                    maxTime: DateTime.utc(
                                        DateTime.now().year + 1, 12, 31, 23, 59),
                                    onConfirm: (date) {
                                  setState(() {
                                    deadline = date;
                                  });
                                }, currentTime: DateTime.now());
                              }
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.orangeAccent.withOpacity(0.27),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.date_range,
                                color: Colors.orange,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              deadline == null ? "" : formattedDate(deadline),
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(0.27),
                              ),
                              padding: const EdgeInsets.all(8),
                              child: Icon(
                                Icons.access_time,
                                color: Colors.red,
                                size: 32,
                              ),
                            ),
                            SizedBox(width: 10,),
                            Text(
                              deadline == null ? "" : "${fs(deadline.hour)}:${fs(deadline.minute)}",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }

  buildCourseList(context, courses) {
    if (courses.isEmpty) {
      return Text("No Courses Added");
    }
    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          Icons.assignment,
                          color: Colors.white,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "${course.acronym}",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )),
              ),
            ),
          );
        },
      ),
    );
  }
}

const Map days = {
  1: "Monday",
  2: "Tuesday",
  3: "Wednesday",
  4: "Thursday",
  5: "Friday",
  6: "Saturday",
  7: "Sunday"
};
