import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/exercise_details/cubit/exercise_set_cubit.dart';
import 'package:gym_tracker/exercise_details/widgets/set_card.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';

class ExerciseDetails extends StatefulWidget {
  const ExerciseDetails({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseDetails> createState() => _ExerciseDetailsState();
}

class _ExerciseDetailsState extends State<ExerciseDetails> {
  bool isOpened = true;
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
                  Expanded(
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      direction: Axis.horizontal,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.exercise.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            BlocBuilder<ExerciseSetCubit, ExerciseSetState>(
                              builder: (context, state) {
                                if (state is ExerciseSetInitial) {
                                  BlocProvider.of<ExerciseSetCubit>(context)
                                      .fetchExerciseSets(widget.exercise);
                                } else if (state is ExerciseSetsFetched) {
                                  return Text(
                                      '${state.exerciseSets.length} Sets');
                                }
                                return const Center(
                                  child: Text("Something went wrong"),
                                );
                              },
                            ),
                          ],
                        ),
                        if (context.select((ExercisesCubit exerciseCubit) =>
                            exerciseCubit.isEditing))
                          IconButton(
                              onPressed: () {
                                BlocProvider.of<ExercisesCubit>(context)
                                    .deleteExercise(widget.exercise);
                              },
                              icon: const Icon(Icons.delete))
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (isOpened)
              BlocBuilder<ExerciseSetCubit, ExerciseSetState>(
                builder: (context, state) {
                  if (state is ExerciseSetInitial) {
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
                  } else if (state is ExerciseSetsFetched) {
                    final isEditing = context.select(
                        (ExercisesCubit exerciseCubit) =>
                            exerciseCubit.isEditing);
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: isEditing
                          ? state.exerciseSets.length + 1
                          : state.exerciseSets.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return (index != state.exerciseSets.length)
                            ? SetCard(
                                exerciseSet: state.exerciseSets[index]!,
                                index: index,
                              )
                            : IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  BlocProvider.of<ExerciseSetCubit>(context)
                                      .saveExerciseSet(ExerciseSet(
                                          repetitionCount: state
                                              .exerciseSets[index - 1]!
                                              .repetitionCount,
                                          weight: state
                                              .exerciseSets[index - 1]!.weight,
                                          exerciseId: state
                                              .exerciseSets[index - 1]!
                                              .exerciseId));
                                },
                              );
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
