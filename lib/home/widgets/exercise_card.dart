import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/exercise.dart';

class ExerciseCard extends StatefulWidget {
  const ExerciseCard({super.key, required this.exercise});

  final Exercise exercise;

  @override
  State<ExerciseCard> createState() => _ExerciseCardState();
}

class _ExerciseCardState extends State<ExerciseCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(widget.exercise.name),
        ],
      ),
    );
  }
}
