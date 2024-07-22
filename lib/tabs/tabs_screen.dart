import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/calendar/calendar_screen.dart';
import 'package:gym_tracker/home/cubit/programs_cubit.dart';
import 'package:gym_tracker/home/home_screen.dart';
import 'package:gym_tracker/service/exercises_repository.dart';
import 'package:gym_tracker/service/locator.dart';
import 'package:gym_tracker/tabs/cubit/tabs_cubit.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((TabsCubit cubit) => cubit.pageIndex);
    String pageTitle = switch (selectedTab) {
      0 => "Workouts",
      1 => "Callendar",
      _ => throw UnimplementedError(),
    };
    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle),
        centerTitle: true,
      ),
      body: BlocBuilder<TabsCubit, TabsState>(
        buildWhen: (previous, current) {
          if (current is TabsPageChanged) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is TabsInitial) {
            return IndexedStack(
              index: selectedTab,
              children: [
                BlocProvider(
                  create: (context) => ProgramsCubit(
                      exerciseRepository: locator<ExercisesRepository>()),
                  child: const HomeScreen(),
                ),
                const CalendarScreen(),
              ],
            );
          } else if (state is TabsError) {
            return Center(
              child: Text(
                "Error: ${state.message}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            );
          } else {
            return const Center(child: Text("Something went wrong"));
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: BlocProvider.of<TabsCubit>(context).selectPage,
        currentIndex: selectedTab,
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurface,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_gymnastics_outlined),
            label: "Workouts",
            activeIcon: Icon(Icons.sports_gymnastics),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_month_outlined),
            label: "Calendar",
            activeIcon: Icon(Icons.calendar_month),
          ),
        ],
      ),
    );
  }
}
