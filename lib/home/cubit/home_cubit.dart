import 'package:bloc/bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({required ExercisesRepository exerciseRepository})
      : _exercisesRepository = exerciseRepository,
        super(HomeInitial());

  final ExercisesRepository _exercisesRepository;

  void fetchPrograms() async {
    try {
      final workoutPrograms = await _exercisesRepository.fetchWorkoutPrograms();
      if (workoutPrograms.isEmpty) {
        emit(HomeNoProgramm());
      } else {
        emit(HomeWorkoutProgramsFetched(workoutPrograms));
      }
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
