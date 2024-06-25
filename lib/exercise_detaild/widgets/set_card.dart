import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise.dart';

class SetCard extends StatelessWidget {
  const SetCard({
    super.key,
    required this.exercise,
  });

  final Exercise exercise;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            const Text('1'),
            const SizedBox(width: 15),
            Text('${exercise.name} Reps'),
          ],
        )
      ],
    );
  }
}
