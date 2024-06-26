import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
import 'package:gym_tracker/exercise_details/cubit/exercise_set_cubit.dart';
import 'package:gym_tracker/exercise_details/widgets/set_value_card.dart';

class SetCard extends StatelessWidget {
  const SetCard({
    super.key,
    required this.exerciseSet,
    required this.index,
  });

  final ExerciseSet exerciseSet;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).colorScheme.inversePrimary,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 25),
        child: Column(
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('${index + 1}'),
                SetValueCard(
                  onChanged: (value) {
                    BlocProvider.of<ExerciseSetCubit>(context).saveExerciseSet(
                        ExerciseSet(
                            id: exerciseSet.id,
                            repetitionCount: exerciseSet.repetitionCount,
                            weight: double.parse(value),
                            exerciseId: exerciseSet.exerciseId));
                  },
                  value: exerciseSet.weight,
                  valueLabel: 'KG',
                ),
                SetValueCard(
                  onChanged: (value) {
                    BlocProvider.of<ExerciseSetCubit>(context).saveExerciseSet(
                        ExerciseSet(
                            id: exerciseSet.id,
                            repetitionCount: int.parse(value),
                            weight: exerciseSet.weight,
                            exerciseId: exerciseSet.exerciseId));
                  },
                  value: exerciseSet.repetitionCount,
                  valueLabel: 'Reps',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
