import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:hive/hive.dart';

Future<void> initialiseHive() async {
  //key
  const exercisesKey = 'expercises';
  const workoutProgramsKey = 'workoutPrograms';
  const exerciseSetsKey = 'exerciseSets';
  //adapters
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutProgramAdapter());
  Hive.registerAdapter(ExerciseSetAdapter());
  //boxed
  final exercisesBox = await Hive.openBox<Exercise?>(exercisesKey);
  final workoutProgramsBox =
      await Hive.openBox<WorkoutProgram?>(workoutProgramsKey);
  final exerciseSetsBox =
      await Hive.openBox<ExerciseSet?>(exerciseSetsKey);
  //repository
  ExercisesRepository(
      exercisesBox: exercisesBox, workoutProgramsBox: workoutProgramsBox, exerciseSetsBox: exerciseSetsBox);
}
