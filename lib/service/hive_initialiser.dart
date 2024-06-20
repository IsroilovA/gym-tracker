import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:hive/hive.dart';

Future<void> initialiseHive() async {
  //key
  const exercisesKey = 'expercises';
  const workoutProgramsKey = 'workoutPrograms';
  //adapters
  Hive.registerAdapter(ExerciseAdapter());
  Hive.registerAdapter(WorkoutProgramAdapter());
  //boxed
  final exercisesBox = await Hive.openBox<Exercise>(exercisesKey);
  final workoutProgramsBox =
      await Hive.openBox<WorkoutProgram>(workoutProgramsKey);
  //repository
  ExercisesRepository(
      exercisesBox: exercisesBox, workoutProgramsBox: workoutProgramsBox);
}
