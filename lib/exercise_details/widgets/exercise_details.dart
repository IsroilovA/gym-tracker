import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/exercise_details/cubit/exercise_set_cubit.dart';
import 'package:gym_tracker/exercise_details/widgets/set_card.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  bool isOpened = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Wrap(
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isOpened = !isOpened;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Icon(
                    isOpened
                        ? Icons.arrow_drop_down_outlined
                        : Icons.arrow_drop_up_outlined,
                    size: 40,
                  ),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.exercise.name,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text('${widget.exercise.name} Sets'),
                    ],
                  ),
                ],
              ),
            ),
            if (isOpened)
              BlocBuilder<ExerciseSetCubit, ExerciseSetState>(
                builder: (context, state) {
                  if (state is ExerciseSetInitial) {
                    BlocProvider.of<ExerciseSetCubit>(context)
                        .fetchExerciseSets(widget.exercise);
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is ExerciseSetsFetched) {
                    return ListView.builder(
                      itemCount: state.exerciseSets.length,
                      itemBuilder: (context, index) {
                        return SetCard(exerciseSet: state.exerciseSets[index]!);
                      },
                    );
                  } else if (state is ExerciseSetsError) {
                    return Center(
                      child: Text(state.error),
                    );
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
