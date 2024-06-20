part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeWorkoutProgramsFetched extends HomeState {
  final List<WorkoutProgram?> workoutPrograms;
  HomeWorkoutProgramsFetched(this.workoutPrograms);
}

final class HomeExercisesFetched extends HomeState {
  final List<Exercise?> exercises;
  HomeExercisesFetched(this.exercises);
}

final class HomeNoProgramm extends HomeState {}

final class HomeError extends HomeState {
  final String error;
  HomeError(this.error);
}
