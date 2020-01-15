import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/providers/providers.dart';
import 'package:uni_kit/features/course_schedule/data/models/course.dart';
import 'package:uni_kit/features/dashboard/ui/screens/navigation_screen.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';
import 'package:path_provider/path_provider.dart' as path_provider;


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(appDocumentDirectory.path);
  Hive.registerAdapter(DeadlineAdapter(), 0);
  Hive.registerAdapter(CourseAdapter(), 1);
  Hive.registerAdapter(CourseTimeAdapter(), 2);
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
