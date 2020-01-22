import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'dart:async';
import 'package:http/http.dart'
    as html; // Contains a client for making API calls
import 'package:html/parser.dart'; // Contains HTML parsers to generate a Document object

Future<List<Course>> fetchDoldurXyzData(String username) async {
  var url = 'https://doldur.xyz/$username';
  var response = await html.get(url);
  var document = parse(response.body);
  var table = document.querySelector('tbody');
  Map<String, Course> courseDict = {};

  for (var i = 0; i < table.children.length; i++) {
    var tr = table.children[i];
    for (var j = 1; j < tr.children.length; j++) {
      var td = tr.children[j];
      if (td.hasContent()) {
        var child = td.firstChild;
        var name = child.text.split(' ')[0];
        if (courseDict.containsKey(name)) {
          courseDict[name].hours.add(CourseTime(day: j, hour: i));
        } else {
          var color = '0xFF' + child.attributes['style'].split('#')[1];
          // print(color);
          courseDict[name] = Course(acronym: name, fullName: '-', hours: [CourseTime(day: j, hour: i)], syllabus: [], color: int.parse(color));
        }
      }
    }
    // print(tr);
  }
  // print(table.toString());
  // for(var course in courseDict.values){
  //   print(course);
  // }

  return courseDict.values.toList();
}
