import 'package:flutter/material.dart';

class BetaWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "v.1.0.18\n",
          style: TextStyle(color: Colors.white),
        ),
        Text(
"""
         /\\_/\\  /\\
        / o o \\ \\ \\
       /   Y   \\/ /
      /         \\/
      \\ | | | | /
       `|_|-|_|'
       
Happy Holiday...

Notifications are back and testing! Deadlines transforms into Todos.
""",
          style: TextStyle(color: Colors.white, letterSpacing: 3),
        ),
      ],
    );
  }
}
