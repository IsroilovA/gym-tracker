import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:hive/hive.dart';

Future<void> initialiseHive() async {
  //key
  const exercisesKey = 'expercises';
  //adapters
  Hive.registerAdapter(ExerciseAdapter());
  //boxed
  final exercisesBox = await Hive.openBox<Exercise>(exercisesKey);
  //repository
  ExercisesRepository(exercisesBox: exercisesBox);
}