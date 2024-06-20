import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/home/cubit/home_cubit.dart';
import 'package:gym_tracker/home/widgets/workout_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeInitial) {
                BlocProvider.of<HomeCubit>(context).fetchPrograms();
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (state is HomeNoProgramm) {
                return Column(
                  children: [
                    Text(
                      "No programms yet",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onSurface),
                    ),
                    IconButton(
                      onPressed: () {
                        BlocProvider.of<HomeCubit>(context)
                            .showNewWorkoutDialog(context);
                      },
                      icon: const Icon(Icons.add),
                    ),
                  ],
                );
              } else if (state is HomeWorkoutProgramsFetched) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.workoutPrograms.length,
                    itemBuilder: (context, index) {
                      return WorkoutCard(
                        workoutProgram: state.workoutPrograms[index]!,
                      );
                    },
                  ),
                );
              } else if (state is HomeError) {
                return Center(child: Text(state.error));
              } else {
                return const Center(
                  child: Text("Something went wrong"),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
