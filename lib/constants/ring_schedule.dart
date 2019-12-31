import 'package:flutter/material.dart';
import 'package:uni_kit/models/ring.dart';

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
        "Teknokent",
        "Hazırlık",
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
        "Rektörlük",
        "Batı Yurtlar",
        "A2"
      ],
      TimeOfDay(hour: 19, minute: 0),
      TimeOfDay(hour: 23, minute: 00),
      60,
      WeekDay.weekend),
];
