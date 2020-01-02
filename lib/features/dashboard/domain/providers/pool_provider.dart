import 'package:flutter/material.dart';
import 'package:uni_kit/core/utils/common_functions.dart';
import 'package:uni_kit/features/dashboard/data/constants/pool_schedule.dart';

class PoolProvider {
  TimeOfDay closestSession() {
    var now = DateTime.now();
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
      // print("Pool Updated!");
      return closestSession();
    });
  }
}
