// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deadline.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeadlineAdapter extends TypeAdapter<Deadline> {
  @override
  Deadline read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Deadline(
      course: fields[0] as Course,
      endTime: fields[1] as DateTime,
      key: fields[2] as int,
      description: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Deadline obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.course)
      ..writeByte(1)
      ..write(obj.endTime)
      ..writeByte(2)
      ..write(obj.key)
      ..writeByte(3)
      ..write(obj.description);
  }
}
