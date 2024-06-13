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
  @HiveField(2)
  final int repetitions;
  @HiveField(3)
  final double weight;
  @HiveField(4)
  final String programId;

  Exercise(id, this.name, this.repetitions, this.weight, this.programId)
      : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'repetitions': repetitions,
      'weight': weight,
      'programId': programId,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      map['id'] as String,
      map['name'] as String,
      int.parse(map['repetitions'] as String),
      double.parse(map['weight'] as String),
      map['programId'] as String,
    );
  }
}
