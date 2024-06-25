import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';
import 'package:gym_tracker/exercise_detaild/widgets/exercise_details.dart';

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
      body: BlocBuilder<ExercisesCubit, ExercisesState>(
        builder: (context, state) {
          if (state is ExercisesInitial) {
            BlocProvider.of<ExercisesCubit>(context)
                .fetchProgramExercises(widget.workoutProgram);
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is NoExercises) {
            return Center(
              child: Text(
                "No exercises added",
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Theme.of(context).colorScheme.onSurface),
              ),
            );
          } else if (state is ExercisesFetched) {
            return Flexible(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.exercises.length,
                itemBuilder: (context, index) {
                  return ExerciseDetails(exercise: state.exercises[index]!);
                },
              ),
            );
          } else if (state is ExercisesError) {
            return Center(child: Text(state.error));
          } else {
            return const Center(
              child: Text("Something went wrong"),
            );
          }
        },
      ),
    );
  }
}
