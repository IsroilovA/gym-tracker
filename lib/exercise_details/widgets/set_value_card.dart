import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker/exercise_details/cubit/exercise_set_cubit.dart';
import 'package:gym_tracker/home/cubit/exercises_cubit.dart';

class SetValueCard extends StatefulWidget {
  const SetValueCard(
      {super.key,
      required this.value,
      required this.valueLabel,
      required this.onChanged});

  final dynamic value;
  final String valueLabel;
  final Function(dynamic value) onChanged;

  @override
  State<SetValueCard> createState() => _SetValueCardState();
}

class _SetValueCardState extends State<SetValueCard> {
  final _nameController = TextEditingController();

  @override
  void initState() {
    _nameController.text = widget.value.toString();
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void save(value) {
    widget.onChanged(value);
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = context
        .select((ExercisesCubit exerciseCubit) => exerciseCubit.isEditing);
    return Row(
      children: [
        Card(
          color: isEditing
              ? Theme.of(context).colorScheme.errorContainer
              : Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isEditing
                ? SizedBox(
                    width: 50,
                    height: 10,
                    child: TextField(
                      onEditingComplete: () {
                        save(_nameController.text);
                      },
                      onTapOutside: (event) {
                        save(_nameController.text);
                      },
                      keyboardType: TextInputType.number,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      controller: _nameController,
                    ),
                  )
                : Text('${widget.value}'),
          ),
        ),
        Text(widget.valueLabel),
      ],
    );
  }
}
