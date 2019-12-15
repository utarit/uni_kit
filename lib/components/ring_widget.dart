import 'package:flutter/material.dart';
import 'package:uni_kit/utils/common_functions.dart';

class RingWidget extends StatefulWidget {
  final data;
  RingWidget({this.data});

  @override
  _RingWidgetState createState() => _RingWidgetState();
}

class _RingWidgetState extends State<RingWidget> {

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    if (widget.data == null || widget.data.isEmpty) {
      return Text(
        "Şu an ring yok :(",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(widget.data.length, (index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "${widget.data[index].ring.name} - ${formattedNum(widget.data[index].time.hour)}:${formattedNum(widget.data[index].time.minute)}",
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              Text(
                "${widget.data[index].ring.stops.join(" -> ")}",
                style: TextStyle(fontSize: 12, color: Colors.white60),
              )
            ],
          );
        }),
      );
    }
  }
}
