import 'package:flutter/material.dart';
import 'package:uni_kit/utils/common_functions.dart';

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

  static List<ClosestRing> getRingHours() {
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
        //print(timeNow);
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

  Ring.fromSchedule(this.name, this.stops, TimeOfDay startTime,
      TimeOfDay endTime, int step, this.day) {
    List<TimeOfDay> timeArr = [];
    TimeOfDay tmp = startTime;
    do {
      timeArr.add(tmp);
      //print(tmp);
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

List<Ring> ringList = [
  Ring.fromSchedule(
      "Sarı/Kırmızı",
      [
        "A2",
        "Batı Yurtlar",
        "Bölümler",
        "Hazırlık",
        "Doğu Yurtlar",
        "Bölümler",
        "A2"
      ],
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 16, minute: 50),
      10,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Turuncu",
      [
        "Batı Yurtlar",
        "Bölümler",
        "Hazırlık",
        "Doğu Yurtlar",
        "Bölümler",
        "Garajlar"
      ],
      TimeOfDay(hour: 8, minute: 15),
      TimeOfDay(hour: 8, minute: 25),
      5,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Mavi",
      ["Batı Yurtlar", "Hazırlık", "Doğu Yurtlar", "Bölümler", "Garajlar"],
      TimeOfDay(hour: 8, minute: 15),
      TimeOfDay(hour: 8, minute: 25),
      5,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Kahverengi",
      ["A1", "KKM", "A1"],
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 17, minute: 0),
      15,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Açık Kahve",
      ["A1", "Rektörlük", "Bölümler", "Hazırlık", "A1"],
      TimeOfDay(hour: 8, minute: 30),
      TimeOfDay(hour: 9, minute: 0),
      15,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Turkuvaz",
      ["Batı Yurtlar", "A2"],
      TimeOfDay(hour: 8, minute: 20),
      TimeOfDay(hour: 8, minute: 25),
      5,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Yeşil",
      ["A2", "Hazırlık", "A2"],
      TimeOfDay(hour: 8, minute: 30),
      TimeOfDay(hour: 10, minute: 0),
      15,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Mor",
      [
        "Batı Yurtlar",
        "Doğu Yurtlar",
        "A1",
        "Rektörlük",
        "Batı Yurtlar",
      ],
      TimeOfDay(hour: 19, minute: 30),
      TimeOfDay(hour: 23, minute: 30),
      30,
      WeekDay.weekday),
  Ring.fromSchedule(
      "Lacivert",
      [
        "A2",
        "Batı Yurtlar",
        "Bölümler",
        "Hazırlık",
        "Doğu Yurtlar",
        "A1",
        "Hazırlık",
        "A2",
      ],
      TimeOfDay(hour: 17, minute: 30),
      TimeOfDay(hour: 19, minute: 00),
      45,
      WeekDay.weekday),
  Ring.weekendShift(
      "Gri - Sabah",
      [
        "A2",
        "Batı Yurtlar",
        "Teknokent" "Hazırlık",
        "Doğu Yurtlar",
        "A1",
        "Rektörlük",
        "Batı Yurtlar",
        "A2"
      ],
      TimeOfDay(hour: 9, minute: 0),
      TimeOfDay(hour: 18, minute: 00),
      60,
      WeekDay.weekend),
  Ring.weekendShift(
      "Gri - Akşam",
      [
        "A2",
        "Batı Yurtlar",
        "Doğu Yurtlar",
        "A1",
        "Rekötürlük",
        "Batı Yurtlar",
        "A2"
      ],
      TimeOfDay(hour: 19, minute: 0),
      TimeOfDay(hour: 23, minute: 00),
      60,
      WeekDay.weekend),
];
