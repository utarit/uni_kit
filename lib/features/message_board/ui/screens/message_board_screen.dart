import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/message_board/data/models/message.dart';

class MessageBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: Container(
        child: ListView.builder(
          itemCount: messages.length,
          itemBuilder: (context, i){
            Message message = messages[i];
            return Container(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            if(message.tags.length > 0)
            SizedBox(
              height: 16,
              child: ListView.builder(
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: message.tags.length,
                itemBuilder: (context, index) {
                  return Container(
                    child: Text(
                      " #" + message.tags[index],
                      style: TextStyle(
                        // color: Color(message.tags[index].colorValue),
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
                    message.content,
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
                Container(
                  child: Text(
                    "${message.postedTime.day} ${months[message.postedTime.month]} ${message.postedTime.year} | ${formattedNum(message.postedTime.hour)}.${formattedNum(message.postedTime.minute)}",
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
          },
        )
      ),
    );
  }
}