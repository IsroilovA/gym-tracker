import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/exercise_details/cubit/exercise_set_cubit.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:gym_tracker/service/locator.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.exercise.name,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
              const SizedBox(height: 8),
              BlocProvider(
                create: (context) => ExerciseSetCubit(
                    exerciseRepository: locator<ExercisesRepository>()),
                child: BlocBuilder<ExerciseSetCubit, ExerciseSetState>(
                  builder: (context, state) {
                    if (state is ExerciseSetInitial) {
                      BlocProvider.of<ExerciseSetCubit>(context)
                          .fetchExerciseSets(widget.exercise);
                    } else if (state is ExerciseSetsFetched) {
                      return Text(
                          '${state.exerciseSets.length} x ${state.exerciseSets.first!.repetitionCount}');
                    }
                    return const Center(
                      child: Text("Something went wrong"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
