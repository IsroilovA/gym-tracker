import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/exercise_details/cubit/exercise_set_cubit.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';
import 'package:gym_tracker/exercise_details/widgets/exercise_details.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:gym_tracker/service/helper_functions.dart';
import 'package:gym_tracker/service/locator.dart';

class ProgramDetails extends StatefulWidget {
  const ProgramDetails({super.key, required this.workoutProgram});

  final WorkoutProgram workoutProgram;

  @override
  State<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutProgram.name),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25, right: 15, left: 15),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ExercisesCubit, ExercisesState>(
                builder: (context, state) {
                  if (state is ExercisesInitial) {
                    BlocProvider.of<ExercisesCubit>(context)
                        .fetchProgramExercises(widget.workoutProgram);
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is NoExercises) {
                    return Column(
                      children: [
                        Text(
                          "No exercises added",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color:
                                      Theme.of(context).colorScheme.onSurface),
                        ),
                        IconButton(
                            onPressed: () {
                             showNewEntryDialog(
                                    context: context,
                                    isWorkout: false,
                                    onSaveClicked: (name) {
                                      BlocProvider.of<ExercisesCubit>(context)
                                          .saveProgramExercises(Exercise(
                                              name: name,
                                              programId:
                                                  widget.workoutProgram.id));
                                    },
                                  );
                            },
                            icon: const Icon(Icons.add)),
                      ],
                    );
                  } else if (state is ExercisesFetched) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: isEditing
                          ? state.exercises.length + 1
                          : state.exercises.length,
                      itemBuilder: (context, index) {
                        return (index != state.exercises.length)
                            ? BlocProvider(
                                create: (context) => ExerciseSetCubit(
                                    exerciseRepository:
                                        locator<ExercisesRepository>()),
                                child: ExerciseDetails(
                                    exercise: state.exercises[index]!),
                              )
                            : TextButton.icon(
                                onPressed: () {
                                  showNewEntryDialog(
                                    context: context,
                                    isWorkout: false,
                                    onSaveClicked: (name) {
                                      BlocProvider.of<ExercisesCubit>(context)
                                          .saveProgramExercises(Exercise(
                                              name: name,
                                              programId:
                                                  widget.workoutProgram.id));
                                    },
                                  );
                                },
                                label: const Text('New Exercise'),
                                icon: const Icon(Icons.add));
                      },
                    );
                  } else if (state is ExercisesError) {
                    return Center(child: Text(state.error));
                  } else {
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  }
                },
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  BlocProvider.of<ExercisesCubit>(context)
                      .changeEditingStatus();
                  isEditing = !isEditing;
                });
              },
              style: OutlinedButton.styleFrom(
                  backgroundColor:
                      Theme.of(context).colorScheme.primaryContainer,
                  minimumSize: Size(size.width, 45)),
              icon: Icon(isEditing ? Icons.save : Icons.edit),
              label: Text(
                isEditing ? "Save" : 'Edit',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            )
          ],
        ),
      ),
    );
  }
}
