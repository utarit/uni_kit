import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/agenda_screen.dart';
import 'package:uni_kit/features/dashboard/ui/screens/home_screen.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_tag_provider.dart';
import 'package:uni_kit/features/todo_list/ui/screens/todo_screen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 1;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final screenList = [
    AgendaScreen(),
    HomeScreen(),
    TodoScreen(),
  ];

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initializeNotificationPlugin();
    Provider.of<CourseProvider>(context, listen: false).getCourses();
    Provider.of<TodoTagProvider>(context, listen: false).getTodoTags();
    Provider.of<TodoProvider>(context, listen: false).getTodos().then((_) {
      Provider.of<TodoProvider>(context, listen: false)
          .todos
          .forEach((todo) {
        if (DateTime.now().isBefore(todo.endTime.subtract(Duration(days: 1)))) {
          scheduleNotification(todo);
        } else {
          cancelNotification(todo.key);
        }
      });
    });
  }

  initializeNotificationPlugin() {
    var initializationSettingsAndroid =
        new AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  scheduleNotification(Todo todo) async {
    // print("Hello");
    var scheduledNotificationDateTime =
        todo.endTime.subtract(Duration(days: 1));
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'com.maks.metu_buddy', 'UniKit', 'University Kit for OTTÜ Students');
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        todo.key,
        '24 saatten az kaldı!',
        todo.description,
        scheduledNotificationDateTime,
        platformChannelSpecifics,
        // payload: todo.key.toString()
        );
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    print("Notification Selected!");
    // await flutterLocalNotificationsPlugin.cancelAll();
    // await Navigator.push(
    //   context,
    //   new MaterialPageRoute(builder: (context) => new SecondScreen(payload)),
    // );
  }

  cancelNotification(int key) async {
    await flutterLocalNotificationsPlugin.cancel(key);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: screenList, index: _selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 2,
        //type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.view_agenda), title: Text("Agenda")),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text("Dashboard")),
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: Text("Todos")),
        ],
      ),
    );
  }
}
