// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expenses_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpensesAdapter extends TypeAdapter<Expenses> {
  @override
  final int typeId = 1;

  @override
  Expenses read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expenses(
      id: fields[0] as String?,
      title: fields[1] as String?,
      description: fields[2] as String?,
      amountSpent: fields[3] as double?,
      platformName: fields[4] as String?,
      createdOn: fields[5] as DateTime?,
      location: fields[6] as String?,
      category: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Expenses obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.amountSpent)
      ..writeByte(4)
      ..write(obj.platformName)
      ..writeByte(5)
      ..write(obj.createdOn)
      ..writeByte(6)
      ..write(obj.location)
      ..writeByte(7)
      ..write(obj.category);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpensesAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
