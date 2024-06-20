part of 'programs_cubit.dart';

@immutable
sealed class ProgramsState {}

final class ProgramsInitial extends ProgramsState {}

final class ProgramsFetched extends ProgramsState {
  final List<WorkoutProgram?> workoutPrograms;
  ProgramsFetched(this.workoutPrograms);
}

final class NoPrograms extends ProgramsState {}

final class ProgramsError extends ProgramsState {
  final String error;
  ProgramsError(this.error);
}
