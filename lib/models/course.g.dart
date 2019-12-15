// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CourseAdapter extends TypeAdapter<Course> {
  @override
  Course read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Course(
      acronym: fields[0] as String,
      fullName: fields[1] as String,
      hours: (fields[2] as List)?.cast<CourseTime>(),
      syllabus: (fields[3] as List)?.cast<String>(),
      color: fields[5] as int,
    )..key = fields[4] as int;
  }

  @override
  void write(BinaryWriter writer, Course obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.acronym)
      ..writeByte(1)
      ..write(obj.fullName)
      ..writeByte(2)
      ..write(obj.hours)
      ..writeByte(3)
      ..write(obj.syllabus)
      ..writeByte(4)
      ..write(obj.key)
      ..writeByte(5)
      ..write(obj.color);
  }
}

class CourseTimeAdapter extends TypeAdapter<CourseTime> {
  @override
  CourseTime read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CourseTime(
      day: fields[1] as int,
      hour: fields[0] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CourseTime obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.hour)
      ..writeByte(1)
      ..write(obj.day);
  }
}
