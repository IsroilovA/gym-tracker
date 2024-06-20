part of 'exercises_cubit.dart';

@immutable
sealed class ExercisesState {}

final class ExercisesInitial extends ExercisesState {}

final class ExercisesFetched extends ExercisesState {
  final List<Exercise?> exercises;
  ExercisesFetched(this.exercises);
}

final class NoExercises extends ExercisesState {}

final class ExercisesError extends ExercisesState {
  final String error;
  ExercisesError(this.error);
}
