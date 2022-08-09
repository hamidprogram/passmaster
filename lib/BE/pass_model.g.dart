// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pass_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class passAdapter extends TypeAdapter<pass> {
  @override
  final int typeId = 1;

  @override
  pass read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return pass(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, pass obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.subject)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is passAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
