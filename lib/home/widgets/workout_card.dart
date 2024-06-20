import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/home/cubit/programs_cubit.dart';

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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.workoutProgram.name),
                IconButton(
                    onPressed: () {
                      BlocProvider.of<ProgramsCubit>(context)
                          .showNewWorkoutDialog(context);
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
