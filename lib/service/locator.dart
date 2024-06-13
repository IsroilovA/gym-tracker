import 'package:get_it/get_it.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:hive/hive.dart';

final GetIt locator = GetIt.instance;

Future<void> initialiseLocator() async {
  //key
  const exercisesKey = 'expercises';
  //box
  final exercisesBox = await Hive.openBox<Exercise?>(exercisesKey);
  //locator
  locator.registerSingleton(ExercisesRepository(exercisesBox: exercisesBox));
}
