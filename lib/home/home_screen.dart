import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/data/models/workout_program.dart';
import 'package:gym_tracker/exercise_details/cubit/exercises_cubit.dart';
import 'package:gym_tracker/home/cubit/programs_cubit.dart';
import 'package:gym_tracker/home/widgets/workout_card.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:gym_tracker/service/helper_functions.dart';
import 'package:gym_tracker/service/locator.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<ProgramsCubit, ProgramsState>(
              builder: (context, state) {
                if (state is ProgramsInitial) {
                  BlocProvider.of<ProgramsCubit>(context).fetchPrograms();
                } else if (state is NoPrograms) {
                  return Column(
                    children: [
                      Text(
                        "No programms yet",
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Theme.of(context).colorScheme.onSurface),
                      ),
                      IconButton(
                        onPressed: () {
                          showNewEntryDialog(
                            context: context,
                            onSaveClicked: (name) {
                              BlocProvider.of<ProgramsCubit>(context)
                                  .saveWorkoutProgram(
                                      WorkoutProgram(name: name));
                            },
                          );
                        },
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  );
                } else if (state is ProgramsFetched) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: state.workoutPrograms.length + 1,
                      itemBuilder: (context, index) {
                        return (index != state.workoutPrograms.length)
                            ? BlocProvider(
                                create: (context) => ExercisesCubit(
                                    exerciseRepository:
                                        locator<ExercisesRepository>()),
                                child: WorkoutCard(
                                  workoutProgram: state.workoutPrograms[index]!,
                                ),
                              )
                            : IconButton(
                                icon: const Icon(Icons.add),
                                onPressed: () {
                                  showNewEntryDialog(
                                    context: context,
                                    onSaveClicked: (name) {
                                      BlocProvider.of<ProgramsCubit>(context)
                                          .saveWorkoutProgram(
                                              WorkoutProgram(name: name));
                                    },
                                  );
                                },
                              );
                      },
                    ),
                  );
                } else if (state is ProgramsError) {
                  return Center(child: Text(state.error));
                }
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
