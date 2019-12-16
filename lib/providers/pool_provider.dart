import 'package:flutter/material.dart';
import 'package:uni_kit/constants/pool_schedule.dart';
import 'package:uni_kit/utils/common_functions.dart';

class PoolProvider {
  TimeOfDay closestSession() {
    var now = DateTime.now();
    // print("Hello");
    for (TimeOfDay session in sessions) {
      if (totalMin(session.hour, session.minute) >=
          totalMin(now.hour, now.minute)) {
        return session;
      }
    }
    return null;
  }

    Stream<TimeOfDay> poolStream() async* {
    yield closestSession();
    Duration delay = Duration(minutes: 30);
    yield* Stream<TimeOfDay>.periodic(delay, (_) {
      print("Pool Updated!");
      return closestSession();
    });
  }
}
