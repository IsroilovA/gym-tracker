import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'workout_program.g.dart';

const uuid = Uuid();

@HiveType(typeId: 1)
class WorkoutProgram {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String id;

  WorkoutProgram(this.name, id) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  factory WorkoutProgram.fromMap(Map<String, dynamic> map) {
    return WorkoutProgram(
      map['id'] as String,
      map['name'] as String,
    );
  }
}
