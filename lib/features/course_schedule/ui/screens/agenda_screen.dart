import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/course_edit_screen.dart';
import 'package:uni_kit/features/course_schedule/ui/widgets/course_list_widget.dart';
import 'package:uni_kit/features/course_schedule/ui/widgets/schedule_widget.dart';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  String username = "";
  bool loading = false;

  _navigateEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CourseEditScreen(), settings: RouteSettings(name: 'CourseEditScreen'),),
    );
  }

  _showDoldurXyzModel(BuildContext context) {
    Scaffold.of(context).showBottomSheet((context) {
      return StatefulBuilder(builder: (context, setState) {
        return Container(
            color: Colors.grey[200],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Get courses from doldur.xyz",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                      "Enter your doldur.xyz username. Your schedule will be parsed and saved here. This action will erase your existing courses."),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: TextField(
                    onChanged: (str) {
                      setState(() {
                        username = str;
                      });
                    },
                    decoration: InputDecoration(
                      hintStyle: TextStyle(fontSize: 17),
                      hintText: 'Username (http://doldur.xyz/username)',
                      // suffixIcon: Icon(Icons.search),
                      // border: InputBorder(borderSide: ),
                      // contentPadding: EdgeInsets.all(20),
                    ),
                  ),
                ),
                if (loading)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: CircularProgressIndicator(),
                  ),
                Center(
                  child: FlatButton(
                    onPressed: () async {
                      setState(() {
                        loading = true;
                      });
                      try {
                        await Provider.of<CourseProvider>(context,
                                listen: false)
                            .fetchCoursesFromDoldurXyz(username);
                      } catch (e) {

                      }

                      setState(() {
                        loading = false;
                      });
                      Navigator.pop(context);
                    },
                    color: Colors.grey[300],
                    child: Text("Get Courses"),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ));
      });
    });
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
                "Schedule",
                style: TextStyle(
                    fontFamily: "Galano",
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  FlatButton(
                    child: Text('Doldur.xyz'),
                    onPressed: () {
                      _showDoldurXyzModel(context);
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.add,
                      size: 30,
                    ),
                    onPressed: () {
                      _navigateEditScreen(context);
                    },
                  ),
                ],
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
