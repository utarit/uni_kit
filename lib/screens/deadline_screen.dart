import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:uni_kit/models/deadline.dart';
import 'package:uni_kit/screens/deadline_edit_screen.dart';
import 'package:uni_kit/utils/common_functions.dart';

class DeadlineScreen extends StatefulWidget {
  @override
  _DeadlineScreenState createState() => _DeadlineScreenState();
}

class _DeadlineScreenState extends State<DeadlineScreen> {
  // final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  final Map<String, Color> colorList = {
    "lastDay": Colors.red,
    "lastWeek": Colors.orange,
    "others": Colors.green,
    "passed": Colors.grey
  };

  // @override
  // void initState() {
  //   super.initState();

  //   initializeNotifications();
  // }

  // Future onSelectNotification(String payload) async  {
  //   //flutterLocalNotificationsPlugin.cancelAll();
  //   await Navigator.push(
  //       context,
  //       MaterialPageRoute(builder: (context) => NavigationScreen()),
  //     );
  // }

  // void initializeNotifications() {
  //   final settingsAndroid = AndroidInitializationSettings('app_icon');
  //   final settingsIOS = IOSInitializationSettings(
  //       onDidReceiveLocalNotification: (id, title, body, payload) =>
  //           onSelectNotification(payload));

  //   flutterLocalNotificationsPlugin.initialize(
  //       InitializationSettings(settingsAndroid, settingsIOS),
  //       onSelectNotification: onSelectNotification);
      

  //   scheduleNotification();
  // }

  // void scheduleNotification() async {
  //   var time =  Time(8, 30, 0);
  //   var deadlines = await sortedDeadlines();
  //   var todaysDeadlines = deadlines.where((deadline) => deadline.endTime.difference(DateTime.now()) < Duration(days: 1)).toList();

  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     'com.maks.metu_buddy',
  //     'METU Buddy',
  //     'Deadline Reminder',
  //     playSound: false
  //   );
  //   var iOSPlatformChannelSpecifics = IOSNotificationDetails();
  //   NotificationDetails platformChannelSpecifics = NotificationDetails(
  //       androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  //   for (var deadline in todaysDeadlines) {
  //     await flutterLocalNotificationsPlugin.showDailyAtTime(
  //         deadline.key,
  //         'Son 1 gün 🐣. ',
  //         "${deadline.description}",
  //         time,
  //         platformChannelSpecifics);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: sortedDeadlines(),
        builder: (context, snapshot) {
          if (snapshot.hasData && !snapshot.hasError) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, top: 45.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Deadlines",
                        style: TextStyle(
                            fontFamily: "Galano",
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          _navigateDeadlineEditScreen(context);
                        },
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text("You can swipe to delete",
                      style: TextStyle(color: Colors.black38)),
                ),
                Expanded(
                  child: buildListView(snapshot.data),
                )
              ],
            );
          }

          return Scaffold(body: Center(child: CircularProgressIndicator()));
        });
  }

  ListView buildListView(List<Deadline> deadlines) {
    final deadlinesBox = Hive.box("deadlines");
    return ListView.builder(
      itemCount: deadlines.length,
      itemBuilder: (context, index) {
        final deadline = deadlines[index];
        var t = deadline.endTime;
        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            deadlinesBox.delete(deadline.key);
          },
          background: Container(
            padding: EdgeInsets.only(right: 16),
            alignment: Alignment.centerRight,
            color: Colors.redAccent[400],
            child: Icon(Icons.delete, color: Colors.white),
          ),
          key: UniqueKey(),
          child: Container(
            // margin: EdgeInsets.only(bottom: 2),
            color: chooseTileColor(deadline.endTime),
            child: ListTile(
              title: Text(deadline.course.acronym),
              subtitle: Text(deadline.description),
              trailing: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "${t.day} ${months[t.month]}",
                      style: TextStyle(
                          color: chooseTileColor(deadline.endTime),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "${formattedNum(t.hour)}:${formattedNum(t.minute)}",
                      style: TextStyle(
                          color: chooseTileColor(deadline.endTime),
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  chooseTileColor(DateTime deadline) {
    final now = DateTime.now();
    if (deadline.isBefore(now)) {
      return Colors.grey;
    } else if (deadline.difference(now) < Duration(days: 1)) {
      return Colors.red;
    } else if (deadline.difference(now) < Duration(days: 7)) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  Future<List<Deadline>> sortedDeadlines() async {
    await Hive.openBox("deadlines");
    final deadlinesBox = Hive.box("deadlines");
    List<Deadline> deadlines = [];
    for (int i = 0; i < deadlinesBox.length; i++) {
      final deadline = deadlinesBox.getAt(i) as Deadline;
      deadlines.add(deadline);
    }

    deadlines.sort((a, b) => a.endTime.compareTo(b.endTime));
    return deadlines;
  }

  _navigateDeadlineEditScreen(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeadlineEditScreen()),
    );

    if (result != null) {
      Deadline deadline = Deadline(
          course: result["course"],
          description: result["description"],
          key: DateTime.now().millisecondsSinceEpoch % UPPER_LIMIT,
          endTime: result["deadline"]);
      Hive.box("deadlines").put(deadline.key, deadline);

      // setState(() {
      //   deadlines.add(deadline);
      // });
    }
  }
}
