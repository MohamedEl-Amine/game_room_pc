// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NamesBillardAdapter extends TypeAdapter<NamesBillard> {
  @override
  final int typeId = 0;

  @override
  NamesBillard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NamesBillard(
      name: fields[0] as String,
      isdone: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, NamesBillard obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.isdone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NamesBillardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class pesPostAdapter extends TypeAdapter<pesPost> {
  @override
  final int typeId = 1;

  @override
  pesPost read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return pesPost(
      name: fields[0] as String,
      numberofplayers: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, pesPost obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.numberofplayers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is pesPostAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class creditAdapter extends TypeAdapter<credit> {
  @override
  final int typeId = 2;

  @override
  credit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return credit(
      name: fields[0] as String,
      amount: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, credit obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.amount)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is creditAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
