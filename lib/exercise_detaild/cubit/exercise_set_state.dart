part of 'exercise_set_cubit.dart';

@immutable
sealed class ExerciseSetState {}

final class ExerciseSetInitial extends ExerciseSetState {}

final class ExerciseSetsFetched extends ExerciseSetState {
  final List<ExerciseSet?> exerciseSets;
  ExerciseSetsFetched(this.exerciseSets);
}

final class ExerciseSetsError extends ExerciseSetState {
  final String error;
  ExerciseSetsError(this.error);
}

