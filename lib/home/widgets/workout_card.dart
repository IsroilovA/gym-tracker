import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/workout_program.dart';

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
      child: Column(
        children: [
          Row(
            children: [
              Text(widget.workoutProgram.name),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add))
            ],
          )
        ],
      ),
    );
  }
}
