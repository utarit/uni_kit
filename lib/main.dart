import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/providers/providers.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/dashboard/ui/screens/navigation_screen.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:uni_kit/features/todo_list/data/models/todo_tag.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(TodoAdapter(), 0);
  Hive.registerAdapter(CourseAdapter(), 1);
  Hive.registerAdapter(CourseTimeAdapter(), 2);
  Hive.registerAdapter(TodoTagAdapter(), 3);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'UniKit',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: "Roboto"),
        home: NavigationScreen(),
      ),
    );
  }
}
