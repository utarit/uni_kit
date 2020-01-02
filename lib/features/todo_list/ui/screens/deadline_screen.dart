import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';
import 'package:uni_kit/features/todo_list/domain/providers/todo_provider.dart';
import 'package:uni_kit/features/todo_list/ui/screens/deadline_edit_screen.dart';

class DeadlineScreen extends StatelessWidget {
  final Map<String, Color> colorList = {
    "lastDay": Colors.red,
    "lastWeek": Colors.orange,
    "others": Colors.green,
    "passed": Colors.grey
  };

  @override
  Widget build(BuildContext context) {
    print("Deadline Screen built");

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, top: 45.0),
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
          child: Selector<TodoProvider, List<Deadline>>(
            selector: (context, TodoProvider todoProvider) =>
                todoProvider.deadlines,
            builder: (context, List<Deadline> deadlines, child) =>
                buildListView(deadlines),
          ),
        )
      ],
    );
  }

  ListView buildListView(List<Deadline> deadlines) {

    var sorted = sortedDeadlines(deadlines);

    return ListView.builder(
      itemCount: sorted.length,
      itemBuilder: (context, index) {
        final deadline = sorted[index];
        var t = deadline.endTime;
        return Dismissible(
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            Provider.of<TodoProvider>(context, listen: false)
                .deleteDeadline(deadline.key);
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

  List<Deadline> sortedDeadlines(List<Deadline> deadlines) {
    deadlines.sort((a, b) => a.endTime.compareTo(b.endTime));
    return deadlines;
  }

  _navigateDeadlineEditScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => DeadlineEditScreen()),
    );
  }
}
