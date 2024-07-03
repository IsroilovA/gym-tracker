import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:hive/hive.dart';

class ExercisesRepository {
  ExercisesRepository(
      {required Box<Exercise?> exercisesBox,
      required Box<WorkoutProgram?> workoutProgramsBox,
      required Box<ExerciseSet?> exerciseSetsBox})
      : _exercisesBox = exercisesBox,
        _workoutProgramsBox = workoutProgramsBox,
        _exerciseSetsBox = exerciseSetsBox;

  final Box<Exercise?> _exercisesBox;
  final Box<WorkoutProgram?> _workoutProgramsBox;
  final Box<ExerciseSet?> _exerciseSetsBox;

  Future<void> saveExerciseSet(ExerciseSet exerciseSet) async {
    await _exerciseSetsBox.put(exerciseSet.id, exerciseSet);
  }

  List<ExerciseSet?> fetchExerciseSets(Exercise exercise) {
    return _exerciseSetsBox.values
        .where((exerciseSet) => exerciseSet!.exerciseId == exercise.id)
        .toList();
  }

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

  List<Exercise?> fetchWorkoutExercises(WorkoutProgram workoutProgram) {
    return _exercisesBox.values
        .where((exercise) => exercise!.programId == workoutProgram.id)
        .toList();
  }

  Future<void> saveWorkoutProgram(WorkoutProgram workoutProgram) async {
    await _workoutProgramsBox.put(workoutProgram.id, workoutProgram);
  }

  Future<void> deleteWorkout(WorkoutProgram workoutProgram) async {
    await _workoutProgramsBox.delete(workoutProgram.id);
    final exercises = _exercisesBox.values.where(
      (exercise) => exercise!.programId == workoutProgram.id,
    );
    for (final exercise in exercises) {
      final sets = _exerciseSetsBox.values.where(
        (set) => set!.exerciseId == exercise!.id,
      );
      for (var set in sets) {
        _exerciseSetsBox.delete(set!.id);
      }
      _exercisesBox.delete(exercise!.id);
    }
  }

  Future<void> deleteExercise(Exercise exercise) async {
    await _exercisesBox.delete(exercise.id);
    final sets = _exerciseSetsBox.values.where(
      (set) => set!.exerciseId == exercise.id,
    );
    for (var set in sets) {
      _exerciseSetsBox.delete(set!.id);
    }
  }

  Future<void> deleteSet(ExerciseSet exerciseSet) async {
    await _exerciseSetsBox.delete(exerciseSet.id);
  }

  Future<void> editWorkoutName(WorkoutProgram workoutProgram) async {
    await _workoutProgramsBox.put(workoutProgram.id, workoutProgram);
  }

  List<WorkoutProgram?> fetchWorkoutPrograms() {
    print(_exerciseSetsBox.values.length);
    print(_exercisesBox.values);
    print(_workoutProgramsBox.values);
    final List<WorkoutProgram?> workoutPrograms = [];
    for (var program in _workoutProgramsBox.values) {
      workoutPrograms.add(_workoutProgramsBox.get(program!.id));
    }
    return workoutPrograms;
  }
}
