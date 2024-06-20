// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_program.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WorkoutProgramAdapter extends TypeAdapter<WorkoutProgram> {
  @override
  final int typeId = 1;

  @override
  WorkoutProgram read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutProgram(
      name: fields[0] as String,
      id: fields[1] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutProgram obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutProgramAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
