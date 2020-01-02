import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/dashboard/data/constants/ring_schedule.dart';
import 'package:uni_kit/features/dashboard/data/models/ring.dart';

class RingProvider {
  List<ClosestRing> getRingHours() {
    List<Ring> availableRings = [];
    DateTime now = DateTime.now();
    int day = (now.weekday > 5) ? WeekDay.weekend : WeekDay.weekday;
    TimeOfDay timeNow = TimeOfDay.fromDateTime(now);
    for (Ring ring in ringList) {
      if (day == ring.day &&
          totalMin(timeNow.hour, timeNow.minute) <
              totalMin(ring.schedule.last.hour, ring.schedule.last.minute) &&
          totalMin(timeNow.hour + 1, timeNow.minute) >=
              totalMin(ring.schedule.first.hour, ring.schedule.first.minute)) {
        //// print(timeNow);
        availableRings.add(ring);
      }
    }
    List<ClosestRing> closestRings = [];
    for (var ring in availableRings) {
      for (TimeOfDay ringTime in ring.schedule) {
        if (totalMin(ringTime.hour, ringTime.minute) >=
            totalMin(timeNow.hour, timeNow.minute)) {
          closestRings.add(ClosestRing(ring: ring, time: ringTime));
          break;
        }
      }
    }

    return closestRings;
  }

  Stream<List<ClosestRing>> ringStream() async* {
    yield getRingHours();
    Duration delay = Duration(minutes: 1);
    yield* Stream<List<ClosestRing>>.periodic(delay, (_) {
      // print("Ring Updated!");
      return getRingHours();
    });
  }
}
