import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'exercise.g.dart';

const uuid = Uuid();

@HiveType(typeId: 0)
class Exercise {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(3)
  final String programId;

  Exercise(
      {id,
      required this.name,
      required this.programId,})
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'programId': programId,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      id: map['id'] as String,
      name: map['name'] as String,
      programId: map['programId'] as String,
    );
  }
}
