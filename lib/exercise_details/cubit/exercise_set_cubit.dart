import 'package:bloc/bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:meta/meta.dart';

part 'exercise_set_state.dart';

class ExerciseSetCubit extends Cubit<ExerciseSetState> {
  ExerciseSetCubit({required ExercisesRepository exerciseRepository})
      : _exerciseRepository = exerciseRepository,
        super(ExerciseSetInitial());

  final ExercisesRepository _exerciseRepository;

  void fetchExerciseSets(Exercise exercise) async {
    try {
      final exercises = await _exerciseRepository.fetchExerciseSets(exercise);
      emit(ExerciseSetsFetched(exercises));
    } catch (e) {
      emit(ExerciseSetsError(e.toString()));
    }
  }

  void saveExerciseSet(ExerciseSet exerciseSet) {
    try {
      _exerciseRepository.saveExerciseSet(exerciseSet);
      emit(ExerciseSetInitial());
    } catch (e) {
      emit(ExerciseSetsError(e.toString()));
    }
  }
}
