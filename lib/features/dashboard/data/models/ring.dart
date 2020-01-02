import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';

class Ring {
  String name;
  String startLocation;
  final int day;
  List<TimeOfDay> schedule;
  List<String> stops;

  static TimeOfDay closestRing(index, availableRings) {
    DateTime timeNow = DateTime.now();
    for (TimeOfDay ringTime in availableRings[index].schedule) {
      if (totalMin(ringTime.hour, ringTime.minute) >=
          totalMin(timeNow.hour, timeNow.minute)) {
        return ringTime;
      }
    }

    return null;
  }



  Ring.fromSchedule(this.name, this.stops, TimeOfDay startTime,
      TimeOfDay endTime, int step, this.day) {
    List<TimeOfDay> timeArr = [];
    TimeOfDay tmp = startTime;
    do {
      timeArr.add(tmp);
      //// // print(tmp);
      int nextMin = tmp.minute + step;
      tmp = nextMin >= 60
          ? TimeOfDay(hour: tmp.hour + 1, minute: nextMin % 60)
          : TimeOfDay(hour: tmp.hour, minute: nextMin % 60);
    } while (tmp.hour < endTime.hour ||
        (tmp.hour == endTime.hour && tmp.minute <= endTime.minute));
    schedule = timeArr;
  }

  Ring.weekendShift(this.name, this.stops, TimeOfDay startTime,
      TimeOfDay endTime, int step, this.day) {
    List<TimeOfDay> timeArr = [];
    TimeOfDay tmp = startTime;
    do {
      if (!(tmp.hour == 13)) {
        timeArr.add(tmp);
      }
      int nextMin = tmp.minute + step;
      tmp = nextMin >= 60
          ? TimeOfDay(hour: tmp.hour + 1, minute: nextMin % 60)
          : TimeOfDay(hour: tmp.hour, minute: nextMin % 60);
    } while (tmp.hour < endTime.hour ||
        (tmp.hour == endTime.hour && tmp.minute <= endTime.minute));
    if (endTime.hour == 23) {
      timeArr.add(TimeOfDay(hour: 23, minute: 30));
    }

    schedule = timeArr;
  }
}

class WeekDay {
  static const int weekday = 0;
  static const int weekend = 1;
}

class ClosestRing {
  Ring ring;
  TimeOfDay time;

  ClosestRing({this.ring, this.time});
}


