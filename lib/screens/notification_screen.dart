import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  final String payload;

  NotificationScreen(this.payload);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Text("Hello"),
            RaisedButton(
              child: Text("Back"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
