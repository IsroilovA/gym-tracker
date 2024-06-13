import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

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

  Exercise(id, this.name, this.repetitions, this.weight) : id = id ?? uuid.v4();

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'repetitions': repetitions,
      'weight': weight,
    };
  }

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      map['id'] as String,
      map['name'] as String,
      int.parse(map['repetitions'] as String),
      double.parse(map['weight'] as String),
    );
  }
}
