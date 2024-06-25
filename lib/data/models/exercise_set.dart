import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

part 'exercise_set.g.dart';

const uuid = Uuid();

@HiveType(typeId: 2)
class ExerciseSet {
  @HiveField(0)
  final String exerciseId;
  @HiveField(1)
  final int repetitionCount;
  @HiveField(2)
  final String id;
  @HiveField(3)
  final double weight;

  ExerciseSet({
    id,
    required this.repetitionCount,
    required this.weight,
    required this.exerciseId,
  }) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'repetitions': repetitionCount,
      'weight': weight,
      'exerciseId': exerciseId,
    };
  }

  factory ExerciseSet.fromMap(Map<String, dynamic> map) {
    return ExerciseSet(
      id: map['id'] as String,
      repetitionCount: int.parse(map['repetitions'] as String),
      weight: double.parse(map['weight'] as String),
      exerciseId: map['exerciseId'] as String,
    );
  }
}
