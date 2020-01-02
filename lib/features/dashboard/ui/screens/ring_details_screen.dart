import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/dashboard/data/constants/dashboard_tiles.dart';
import 'package:uni_kit/features/dashboard/data/constants/ring_schedule.dart';
import 'package:uni_kit/features/dashboard/data/models/ring.dart';

class RingDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: dashboardTiles[2]["color"],
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          // elevation: 0,
          title: Text(
            "Ring Schedule",
            style: TextStyle(fontFamily: "Galano"),
          ),
          centerTitle: true,
        ),
      body: ListView.builder(
        itemCount: ringList.length,
        itemBuilder: (context, i) {
          return _buildRingSection(context, i);
        },
      ),
    );
  }

  _buildRingSection(context, i) {
    var ring = ringList[i];
    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${ring.name} - ${(ring.day == WeekDay.weekday) ? "Weekday" : "Weekend"}",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 4,),
            _buildHours(context, ring)
          ],
        ));
  }

  _buildHours(context, Ring ring) {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        itemCount: ring.schedule.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  width: 60,
                  color: Colors.blue[900],
                ),
                Positioned(
                  bottom: 7,
                  child: Container(
                    height: 5,
                    width: 60,
                    color: Colors.white,
                  ),
                ),
                Positioned(
                  bottom: 9,
                  child: Container(
                    height: 2,
                    width: 60,
                    color: Colors.red,
                  ),
                ),
                Positioned(
                  bottom: -5,
                  left: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    height: 10,
                    width: 10,
                    
                  ),
                ),
                Positioned(
                  bottom: -5,
                  right: 10,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.black,
                    ),
                    height: 10,
                    width: 10,
                    
                  ),
                ),
                Positioned(
                  bottom: 14,
                  child: Container(
                    child: Text(
                      "${formattedNum(ring.schedule[i].hour)}:${formattedNum(ring.schedule[i].minute)}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
