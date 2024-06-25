import 'package:get_it/get_it.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:hive/hive.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  //key
  const exercisesKey = 'expercises';
  const workoutProgramsKey = 'workoutPrograms';
  const exerciseSetsKey = 'exerciseSets';
  //box
  final exercisesBox = await Hive.openBox<Exercise?>(exercisesKey);
  final workoutProgramsBox =
      await Hive.openBox<WorkoutProgram?>(workoutProgramsKey);
  final exerciseSetsBox = await Hive.openBox<ExerciseSet?>(exerciseSetsKey);
  //locator
  locator.registerSingleton(ExercisesRepository(
      exercisesBox: exercisesBox,
      workoutProgramsBox: workoutProgramsBox,
      exerciseSetsBox: exerciseSetsBox));
}
