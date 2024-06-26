import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/exercise_details/program_details_screen.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';
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
      {required BuildContext context, required WorkoutProgram workoutProgram}) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => BlocProvider(
              create: (context) => ExercisesCubit(
                  exerciseRepository: locator<ExercisesRepository>()),
              child: ProgramDetails(workoutProgram: workoutProgram),
            )));
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
    } catch (e) {
      emit(ProgramsError(e.toString()));
    }
  }

  void showNewWorkoutDialog(BuildContext context) {
    final form = GlobalKey<FormState>();
    String name = '';
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
                      saveWorkoutProgram(WorkoutProgram(name: name));
                      Navigator.of(context).pop();
                      emit(ProgramsInitial());
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
