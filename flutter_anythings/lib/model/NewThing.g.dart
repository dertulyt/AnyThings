// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NewThing.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewThingAdapter extends TypeAdapter<NewThing> {
  @override
  final int typeId = 0;

  @override
  NewThing read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NewThing()
      ..thingMyTitle = fields[0] as String
      ..thingMySubTitle = fields[1] as String
      ..thingMyCount = fields[2] as String;
  }

  @override
  void write(BinaryWriter writer, NewThing obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.thingMyTitle)
      ..writeByte(1)
      ..write(obj.thingMySubTitle)
      ..writeByte(2)
      ..write(obj.thingMyCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewThingAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
