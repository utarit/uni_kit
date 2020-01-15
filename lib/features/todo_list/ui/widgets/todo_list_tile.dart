import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/todo_list/data/models/deadline.dart';

class TodoListTile extends StatelessWidget {
  Deadline deadline;
  TodoListTile(this.deadline);

  @override
  Widget build(BuildContext context) {
    var t = deadline.endTime;

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(border: Border.all(color: Colors.grey), borderRadius: BorderRadius.circular(10)),
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Text(deadline.description, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text(
                  "${t.day} ${months[t.month]} ${t.year} ",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              ),
              Container(
                child: Text(
                  "${formattedNum(t.hour)}.${formattedNum(t.minute)}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
    // return ListTile(
    //   title: Text(deadline.course.acronym),
    //   subtitle: Text(deadline.description),
    //   trailing: Container(
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(10),
    //     ),
    //     padding: EdgeInsets.all(8.0),
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.center,
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    // Text(
    //   "${t.day} ${months[t.month]}",
    //   style: TextStyle(
    //       //color: chooseTileColor(deadline.endTime),
    //       fontSize: 16,
    //       fontWeight: FontWeight.bold),
    // ),
    // Text(
    //   "${formattedNum(t.hour)}:${formattedNum(t.minute)}",
    //   style: TextStyle(
    //       //color: chooseTileColor(deadline.endTime),
    //       fontSize: 16,
    //       fontWeight: FontWeight.bold),
    // ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
