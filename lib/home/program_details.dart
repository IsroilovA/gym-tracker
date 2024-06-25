import 'package:flutter/material.dart';
import 'package:gym_tracker/data/models/workout_program.dart';

class ProgramDetails extends StatefulWidget {
  const ProgramDetails({super.key, required this.workoutProgram});

  final WorkoutProgram workoutProgram;

  @override
  State<ProgramDetails> createState() => _ProgramDetailsState();
}

class _ProgramDetailsState extends State<ProgramDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.workoutProgram.name),
      ),
    );
  }
}
