import 'package:gym_tracker/data/models/exercise.dart';
import 'package:hive/hive.dart';

class ExercisesRepository{
  ExercisesRepository({required Box<Exercise?> exercisesBox}): _exercisesBox = exercisesBox;

  final Box<Exercise?> _exercisesBox;

  Future<void> saveExercise(Exercise exercise)async{
    await _exercisesBox.put(exercise.id, exercise);
  }

  List<Exercise?> fetchExercises(){
    final List<Exercise?> exercises = [];
    for(var exercise in _exercisesBox.values){
      exercises.add(_exercisesBox.get(exercise!.id));
    }
    return exercises;
  }
}