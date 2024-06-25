import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/home/widgets/number_text_field.dart';
import 'package:gym_tracker/service/exercises_repository.dart';

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

  void saveProgramExercises(Exercise exercise) {
    try {
      _exerciseRepository.saveExercise(exercise);
      _exerciseRepository.saveExerciseSet(
          ExerciseSet(repetitionCount: 1, weight: 0, exerciseId: exercise.id));
    } catch (e) {
      emit(ExercisesError(e.toString()));
    }
  }

  void showNewExerciseDialog(
      {required BuildContext context,
      required String workoutProgramId,
      Exercise? exercise}) {
    final form = GlobalKey<FormState>();
    String name = '';
    int repetitions = 0;
    int sets = 0;
    double weight = 0.0;
    if (exercise != null) {
      name = exercise.name;
    }
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "New Program",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
            ),
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.close))
          ],
        ),
        children: [
          Form(
            key: form,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: name,
                  decoration: const InputDecoration(labelText: "Name"),
                  textCapitalization: TextCapitalization.sentences,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                const SizedBox(height: 15),
                NumberTextField(
                  initialValue: repetitions.toString(),
                  inputDecoration: const InputDecoration(labelText: 'Reps'),
                  isDouble: false,
                  onSaved: (value) {
                    repetitions = int.parse(value);
                  },
                ),
                const SizedBox(height: 15),
                NumberTextField(
                  initialValue: sets.toString(),
                  inputDecoration: const InputDecoration(labelText: 'Sets'),
                  isDouble: false,
                  onSaved: (value) {
                    sets = int.parse(value);
                  },
                ),
                const SizedBox(height: 15),
                NumberTextField(
                  initialValue: weight.toString(),
                  inputDecoration: const InputDecoration(
                    labelText: 'Weight',
                    suffixText: 'kg',
                  ),
                  isDouble: true,
                  onSaved: (value) {
                    weight = double.parse(value);
                  },
                ),
                const SizedBox(height: 15),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Theme.of(context).colorScheme.primaryContainer,
                    ),
                    onPressed: () {
                      final isValid = form.currentState!.validate();
                      if (!isValid) {
                        return;
                      }
                      form.currentState!.save();
                      if (exercise == null) {
                        saveProgramExercises(
                            Exercise(name: name, programId: workoutProgramId));
                      } else {
                        saveProgramExercises(Exercise(
                            id: exercise.id,
                            name: name,
                            programId: workoutProgramId));
                      }
                      Navigator.of(context).pop();
                      emit(ExercisesInitial());
                    },
                    child: const Text("Save"),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
