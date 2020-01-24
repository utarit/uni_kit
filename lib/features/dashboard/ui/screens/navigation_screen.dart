import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/providers/notification_provider.dart';
import 'package:uni_kit/features/course_schedule/domain/providers/course_provider.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/agenda_screen.dart';
import 'package:uni_kit/features/dashboard/ui/screens/home_screen.dart';
import 'package:uni_kit/features/message_board/ui/screens/message_board_screen.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_tag_provider.dart';
import 'package:uni_kit/features/todo_list/ui/screens/todo_screen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 1;

  final screenList = [
    AgendaScreen(),
    HomeScreen(),
    TodoScreen(),
    MessageBoardScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Provider.of<NotificationProvider>(context, listen: false)
        .initializeNotificationPlugin();
    Provider.of<CourseProvider>(context, listen: false).getCourses();
    Provider.of<TodoTagProvider>(context, listen: false).getTodoTags();
    Provider.of<TodoProvider>(context, listen: false).getTodos();
  }

  @override
  Widget build(BuildContext context) {
    // print("Navigator Screen Built");

    return Scaffold(
      // body: IndexedStack(children: screenList, index: _selectedIndex)
      body: screenList[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.grey[900],
        // fixedColor: Colors.grey[900],
        selectedItemColor: Colors.grey[900],
        unselectedItemColor: Colors.grey[800],
        // elevation: 2,
        // type: BottomNavigationBarType.shifting,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range), title: Text("Schedule")),
          BottomNavigationBarItem(
              icon: Icon(Icons.dashboard), title: Text("Dashboard")),
          BottomNavigationBarItem(
              icon: Icon(Icons.assignment_turned_in), title: Text("Todos")),
          BottomNavigationBarItem(
              icon: Icon(Icons.message), title: Text("Board")),
        ],
      ),
    );
  }
}
