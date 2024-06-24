import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise.dart';
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
    } catch (e) {
      emit(ExercisesError(e.toString()));
    }
  }

  void showNewExerciseDialog(
      BuildContext context, WorkoutProgram workoutProgram) {
    final form = GlobalKey<FormState>();
    String name = '';
    late int repetitions;
    late double weight;
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
                  isDouble: false,
                  onSaved: (value) {
                    repetitions = int.parse(value);
                  },
                ),
                const SizedBox(height: 15),
                NumberTextField(
                  isDouble: true,
                  onSaved: (value) {
                    weight = double.parse(value);
                  },
                ),
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
                      saveProgramExercises(Exercise(
                          name: name,
                          repetitions: repetitions,
                          weight: weight,
                          programId: workoutProgram.id));
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
