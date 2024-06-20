import 'package:bloc/bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:meta/meta.dart';

part 'exercises_state.dart';

class ExercisesCubit extends Cubit<ExercisesState> {
  ExercisesCubit({required ExercisesRepository exerciseRepository})
      : _exerciseRepository = exerciseRepository,
        super(ExercisesInitial());

  final ExercisesRepository _exerciseRepository;

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
}
