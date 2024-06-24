import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';
import 'package:gym_tracker/home/widgets/exercise_card.dart';

class WorkoutCard extends StatefulWidget {
  const WorkoutCard({super.key, required this.workoutProgram});

  final WorkoutProgram workoutProgram;

  @override
  State<WorkoutCard> createState() => _WorkoutCardState();
}

class _WorkoutCardState extends State<WorkoutCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 10, right: 15, left: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.workoutProgram.name,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                ),
                PopupMenuButton(
                  itemBuilder: (context) {
                    return [
                      PopupMenuItem(
                          onTap: () {
                            BlocProvider.of<ExercisesCubit>(context)
                                .showNewExerciseDialog(
                                    context, widget.workoutProgram);
                          },
                          child: const ListTile(
                            title: Text('add new exercise'),
                            leading: Icon(Icons.add),
                          )),
                      PopupMenuItem(
                          onTap: () {},
                          child: const ListTile(
                            title: Text('edit workout name'),
                            leading: Icon(Icons.edit),
                          )),
                      PopupMenuItem(
                          onTap: () {},
                          child: const ListTile(
                            title: Text('delete workout'),
                            leading: Icon(Icons.delete),
                          )),
                    ];
                  },
                )
              ],
            ),
            const SizedBox(height: 15),
            BlocBuilder<ExercisesCubit, ExercisesState>(
              builder: (context, state) {
                if (state is ExercisesInitial) {
                  BlocProvider.of<ExercisesCubit>(context)
                      .fetchProgramExercises(widget.workoutProgram);
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                } else if (state is NoExercises) {
                  return Center(
                    child: Text(
                      "No exercises added",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                  );
                } else if (state is ExercisesFetched) {
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.exercises.length,
                      itemBuilder: (context, index) {
                        return ExerciseCard(exercise: state.exercises[index]!);
                      },
                    ),
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
          ],
        ),
      ),
    );
  }
}
