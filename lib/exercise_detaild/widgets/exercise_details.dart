import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise.dart';
import 'package:gym_tracker/exercise_detaild/widgets/set_card.dart';

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
            if (isOpened) SetCard(exercise: widget.exercise),
          ],
        ),
      ),
    );
  }
}
