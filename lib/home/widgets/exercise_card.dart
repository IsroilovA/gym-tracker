import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        BlocProvider.of<ExercisesCubit>(context).showNewExerciseDialog(
            context: context,
            workoutProgramId: widget.exercise.programId,
            exercise: widget.exercise);
      },
      child: Card(
        child: Column(
          children: [
            Text(
              widget.exercise.name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Text('${widget.exercise.repetitions}'),
            Text('${widget.exercise.sets}'),
            Text('${widget.exercise.weight}')
          ],
        ),
      ),
    );
  }
}
