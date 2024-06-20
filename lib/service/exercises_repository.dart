import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:hive/hive.dart';

class ExercisesRepository {
  ExercisesRepository(
      {required Box<Exercise?> exercisesBox,
      required Box<WorkoutProgram?> workoutProgramsBox})
      : _exercisesBox = exercisesBox,
        _workoutProgramsBox = workoutProgramsBox;

  final Box<Exercise?> _exercisesBox;
  final Box<WorkoutProgram?> _workoutProgramsBox;

  Future<void> saveExercise(Exercise exercise) async {
    await _exercisesBox.put(exercise.id, exercise);
  }

  List<Exercise?> fetchExercises() {
    final List<Exercise?> exercises = [];
    for (var exercise in _exercisesBox.values) {
      exercises.add(_exercisesBox.get(exercise!.id));
    }
    return exercises;
  }

  Future<void> saveWorkoutProgram(WorkoutProgram workoutProgram) async {
    await _workoutProgramsBox.put(workoutProgram.id, workoutProgram);
  }

  List<WorkoutProgram?> fetchWorkoutPrograms() {
    final List<WorkoutProgram?> workoutPrograms = [];
    for (var program in _workoutProgramsBox.values) {
      workoutPrograms.add(_workoutProgramsBox.get(program!.id));
    }
    return workoutPrograms;
  }
}
