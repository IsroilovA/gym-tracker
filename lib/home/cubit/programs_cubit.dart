import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/exercise_details/program_details_screen.dart';
import 'package:gym_tracker/exercise_details/cubit/exercises_cubit.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:gym_tracker/service/locator.dart';

part 'programs_state.dart';

class ProgramsCubit extends Cubit<ProgramsState> {
  ProgramsCubit({required ExercisesRepository exerciseRepository})
      : _exercisesRepository = exerciseRepository,
        super(ProgramsInitial());

  final ExercisesRepository _exercisesRepository;

  void fetchPrograms() async {
    try {
      final workoutPrograms = await _exercisesRepository.fetchWorkoutPrograms();
      if (workoutPrograms.isEmpty) {
        emit(NoPrograms());
      } else {
        emit(ProgramsFetched(workoutPrograms));
      }
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }

  void navigateToDetailed(
      {required BuildContext context,
      required WorkoutProgram workoutProgram}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => ExercisesCubit(
              exerciseRepository: locator<ExercisesRepository>()),
          child: ProgramDetails(workoutProgram: workoutProgram),
        ),
      ),
    );
    emit(ProgramsInitial());
  }

  void editProgram(WorkoutProgram workoutProgram) {
    try {
      _exercisesRepository.editWorkoutName(workoutProgram);
      emit(ProgramsInitial());
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }

  void deleteWorkout(WorkoutProgram workoutProgram) async {
    try {
      _exercisesRepository.deleteWorkout(workoutProgram);
      emit(ProgramsInitial());
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }

  void saveWorkoutProgram(WorkoutProgram workoutProgram) {
    try {
      _exercisesRepository.saveWorkoutProgram(workoutProgram);
      emit(ProgramsInitial());
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }
}
