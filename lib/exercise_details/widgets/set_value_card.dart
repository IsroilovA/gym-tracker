import 'package:flutter/material.dart';

class SetValueCard extends StatelessWidget {
  const SetValueCard(
      {super.key, required this.value, required this.valueLabel});

  final dynamic value;
  final String valueLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Card(
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$value'),
          ),
        ),
        Text(valueLabel),
      ],
    );
  }
}
