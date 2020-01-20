import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';

class NotificationProvider {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

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

  scheduleTodoNotification(Todo todo) async {
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
