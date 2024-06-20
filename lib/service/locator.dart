import 'package:get_it/get_it.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:hive/hive.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  //key
  const exercisesKey = 'expercises';
  const workoutProgramsKey = 'workoutPrograms';
  //box
  final exercisesBox = await Hive.openBox<Exercise?>(exercisesKey);
  final workoutProgramsBox =
      await Hive.openBox<WorkoutProgram?>(workoutProgramsKey);
  //locator
  locator.registerSingleton(ExercisesRepository(
      exercisesBox: exercisesBox, workoutProgramsBox: workoutProgramsBox));
}
