import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';

part 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit({required ExercisesRepository exerciseRepository})
      : _exerciseRepository = exerciseRepository,
        super(ExercisesInitial());

  final ExercisesRepository _exerciseRepository;

  bool isEditing = false;

  void changeEditingStatus() {
    isEditing = !isEditing;
  }

  void fetchProgramExercises(WorkoutProgram workoutProgram) async {
    try {
      final exercises =
          await _exerciseRepository.fetchWorkoutExercises(workoutProgram);
      if (exercises.isEmpty) {
        emit(NoExercises());
      } else {
        emit(ExercisesFetched(exercises));
      }
    } catch (e) {
      emit(ExercisesError(e.toString()));
    }
  }

  void saveProgramExercises(Exercise exercise) {
    try {
      _exerciseRepository.saveExercise(exercise);
      _exerciseRepository.saveExerciseSet(ExerciseSet(
          repetitionCount: 10, weight: 20, exerciseId: exercise.id));
      emit(ExercisesInitial());
    } catch (e) {
      emit(ExercisesError(e.toString()));
    }
  }
}
