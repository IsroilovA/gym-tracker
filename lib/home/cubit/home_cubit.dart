import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
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

  void saveWorkoutProgram(WorkoutProgram workoutProgram) {
    try {
      _exercisesRepository.saveWorkoutProgram(workoutProgram);
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }

  void showNewWorkoutDialog(BuildContext context) {
    final form = GlobalKey<FormState>();
    String name = '';
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        contentPadding: const EdgeInsets.all(20),
        title: Text(
          "New Work Out Program",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
        ),
        children: [
          Form(
            key: form,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "name"),
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
                TextButton(
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
                    saveWorkoutProgram(WorkoutProgram(name: name));
                  },
                  child: const Text("Save"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
