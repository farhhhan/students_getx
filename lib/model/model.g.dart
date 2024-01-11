// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class StudentModelAdapter extends TypeAdapter<StudentModel> {
  @override
  final int typeId = 1;

  @override
  StudentModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return StudentModel(
      name: fields[0] as String,
      image: fields[2] as String?,
      rollNo: fields[1] as String,
      dob: fields[7] as String?,
      department: fields[4] as String?,
      gender: fields[5] as String?,
      id: fields[3] as int?,
      number: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, StudentModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.rollNo)
      ..writeByte(2)
      ..write(obj.image)
      ..writeByte(3)
      ..write(obj.id)
      ..writeByte(4)
      ..write(obj.department)
      ..writeByte(5)
      ..write(obj.gender)
      ..writeByte(6)
      ..write(obj.number)
      ..writeByte(7)
      ..write(obj.dob);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is StudentModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
