import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uni_kit/models/ring.dart';
import 'package:uni_kit/utils/common_functions.dart';

class RingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    print("Ring Built");
    var ringList = Provider.of<List<ClosestRing>>(context);
    if (ringList == null || ringList.isEmpty) {
      return Text(
        "Şu an ring yok :(",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(ringList.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${ringList[index].ring.name} - ${formattedNum(ringList[index].time.hour)}:${formattedNum(ringList[index].time.minute)}",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Text(
                "${ringList[index].ring.stops.join(" -> ")}",
                style: TextStyle(fontSize: 12, color: Colors.white60),
              )
            ],
          );
        }),
      );
    }
  }
}
