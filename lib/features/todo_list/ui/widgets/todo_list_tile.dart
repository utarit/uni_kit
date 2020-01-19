import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/todo_list/data/models/todo.dart';

class TodoListTile extends StatelessWidget {
  final Todo todo;
  TodoListTile(this.todo);

  chooseTileColor(DateTime todo) {
    final now = DateTime.now();
    if (todo.isBefore(now)) {
      return Colors.grey;
    } else if (todo.difference(now) < Duration(days: 1)) {
      return Colors.red;
    } else if (todo.difference(now) < Duration(days: 7)) {
      return Colors.orange;
    } else {
      return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    var t = todo.endTime;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if(todo.tags.length > 0)
          SizedBox(
            height: 16,
            child: ListView.builder(
              reverse: true,
              scrollDirection: Axis.horizontal,
              itemCount: todo.tags.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Text(
                    " #" + todo.tags[index].label,
                    style: TextStyle(
                      color: Color(todo.tags[index].colorValue),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  todo.description,
                  style: TextStyle(
                    fontSize: 16,
                    // fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                _differenceDuration(t),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
              Container(
                child: Text(
                  "${t.day} ${months[t.month]} ${t.year} | ${formattedNum(t.hour)}.${formattedNum(t.minute)}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  String _differenceDuration(DateTime t) {
    var now = DateTime.now();
    if (t.isBefore(now)) {
      return "Deadline passed";
    }

    Duration duration = t.difference(now);
    if (duration > Duration(days: 1)) {
      return "${duration.inDays} days left";
    } else if (duration > Duration(hours: 1)) {
      return "${duration.inHours} hours left";
    } else {
      return "It's almost come!";
    }
  }
}
