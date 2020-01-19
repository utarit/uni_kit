// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_tag.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoTagAdapter extends TypeAdapter<TodoTag> {
  @override
  TodoTag read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoTag(
      fields[0] as String,
      fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, TodoTag obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.colorValue);
  }
}
