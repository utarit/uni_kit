import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/dashboard/data/models/ring.dart';
import 'package:url_launcher/url_launcher.dart';

class RingWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // print("Ring Built");
    var ringList = Provider.of<List<ClosestRing>>(context);
    if (ringList == null || ringList.isEmpty) {
      return Text(
        "Şu an ring yok :(",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            onPressed: () async {
              const url = 'https://ring.metu.edu.tr';
              if (await canLaunch(url)) {
                await launch(url);
              } else {
                throw 'Could not launch $url';
              }
            },
            child: SizedBox(
              width: double.infinity,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Where is Ring? ",
                      style: TextStyle(color: Colors.black),
                    ),
                    Icon(Icons.open_in_new, size: 16)
                  ],
                ),
              ),
            ),
          ),
          Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(ringList.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "${ringList[index].ring.name}:\n${ringList[index].prevTime != null ? formattedNum(ringList[index].prevTime.hour) : ''}:${ringList[index].prevTime != null ? formattedNum(ringList[index].prevTime.minute) : ''} ->  ${formattedNum(ringList[index].time.hour)}:${formattedNum(ringList[index].time.minute)}",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.white),
                    ),
                    Text(
                      "${ringList[index].ring.stops.join(" -> ")}",
                      style: TextStyle(fontSize: 12, color: Colors.white60),
                    )
                  ],
                );
              })),
          Center(
            child: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          )
        ],
      );
    }
  }
}
