import 'package:bloc/bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

part 'exercise_set_state.dart';

class ExerciseSetCubit extends Cubit<ExerciseSetState> {
  ExerciseSetCubit({required ExercisesRepository exerciseRepository})
      : _exerciseRepository = exerciseRepository,
        super(ExerciseSetInitial());

  final ExercisesRepository _exerciseRepository;

  List<ExerciseSet?> exerciseSets = [];

  void fetchExerciseSets(Exercise exercise) async {
    try {
      exerciseSets = await _exerciseRepository.fetchExerciseSets(exercise);
      if (exerciseSets.isEmpty) {
        emit(NoSets());
      } else {
        emit(ExerciseSetsFetched(exerciseSets));
      }
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

  void deleteSet(ExerciseSet exerciseSet) {
    try {
      _exerciseRepository.deleteSet(exerciseSet);
      emit(ExerciseSetInitial());
    } catch (e) {
      emit(ExerciseSetsError(e.toString()));
    }
  }
}
