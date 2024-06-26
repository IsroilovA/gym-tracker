import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise_set.dart';
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
                  value: exerciseSet.weight,
                  valueLabel: 'KG',
                ),
                SetValueCard(
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
