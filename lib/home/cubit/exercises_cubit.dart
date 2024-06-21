import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

  void saveProgramExercises(Exercise exercise) {
    try {
      _exerciseRepository.saveExercise(exercise);
    } catch (e) {
      emit(ExercisesError(e.toString()));
    }
  }

  void showNewExerciseDialog(BuildContext context) {
    final form = GlobalKey<FormState>();
    final repetitionsController = TextEditingController(text: '0');
    String name = '';
    int repetitions;
    double weight;
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
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          String newText =
                              (int.parse(repetitionsController.value.text) - 1)
                                  .toString();
                          repetitionsController.value =
                              repetitionsController.value.copyWith(
                                  text: newText,
                                  selection: TextSelection.collapsed(
                                      offset: newText.length));
                        },
                        icon: const Icon(Icons.minimize_outlined)),
                    TextFormField(
                      controller: repetitionsController,
                      decoration:
                          const InputDecoration(labelText: "Repetitions"),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter the number';
                        } else if (int.tryParse(value) == null) {
                          return 'You can enter numbers only';
                        }
                        return null;
                      },
                      onSaved: (newValue) => repetitions = int.parse(newValue!),
                    ),
                    IconButton(
                        onPressed: () {
                          String newText =
                              (int.parse(repetitionsController.value.text) + 1)
                                  .toString();
                          repetitionsController.value =
                              repetitionsController.value.copyWith(
                                  text: newText,
                                  selection: TextSelection.collapsed(
                                      offset: newText.length));
                        },
                        icon: const Icon(Icons.add)),
                  ],
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
                      // form.currentState!.save();
                      // saveWorkoutProgram(WorkoutProgram(name: name));
                      // Navigator.of(context).pop();
                      // emit(ProgramsInitial());
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
