import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';

class NotificationProvider {
  static const halfOurDuration = Duration(minutes: 30);
  static const oneDayDuration = Duration(days: 1);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotificationPlugin() {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS =
        IOSInitializationSettings(onDidReceiveLocalNotification: null);
    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  scheduleTodoNotification(Todo todo, bool halfOur) async {
    // print("Hello");
    var scheduledNotificationDateTime =
        todo.endTime.subtract(halfOur ? halfOurDuration : oneDayDuration);
    var vibrationPattern = Int64List(4);
    vibrationPattern[0] = 0;
    vibrationPattern[1] = 1000;
    vibrationPattern[2] = 5000;
    vibrationPattern[3] = 2000;
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'com.maks.metu_buddy', 'UniKit', 'University Kit for OTTÜ Students',
      //icon: 'secondary_icon',
      sound: 'slow_spring_board',
      largeIcon: 'sample_large_icon',
      largeIconBitmapSource: BitmapSource.Drawable,
      vibrationPattern: vibrationPattern,
      enableLights: true,
      color: const Color(0xFFeb4034),
      ledColor: const Color(0xFFFF0000),
      ledOnMs: 1000,
      ledOffMs: 500,
      icon: 'app_icon'
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    NotificationDetails platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
      todo.key,
      halfOur ? 'Last 30 minutes!' : 'Last 24 hours!',
      todo.description,
      scheduledNotificationDateTime,
      platformChannelSpecifics,
      // payload: todo.key.toString()
    );
  }

  Future onSelectNotification(String payload) async {
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
}
