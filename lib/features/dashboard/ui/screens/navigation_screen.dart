import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/features/course_schedule/ui/screens/agenda_screen.dart';
import 'package:uni_kit/features/dashboard/ui/screens/home_screen.dart';
import 'package:uni_kit/features/todo_list/ui/screens/deadline_screen.dart';


class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int _selectedIndex = 1;

  final screenList = [
    AgendaScreen(),
    HomeScreen(),
    DeadlineScreen(),
  ];

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: screenList, index: _selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.date_range), title: Text("Deadlines")),
        ],
      ),
    );
  }
}
