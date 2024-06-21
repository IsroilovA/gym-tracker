import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({super.key, required this.onSaved});

  final ValueChanged<int> onSaved;

  @override
  Widget build(BuildContext context) {
    final repetitionsController = TextEditingController(text: '0');
    return Row(
      children: [
        IconButton(
            onPressed: () {
              if (repetitionsController.text != '0') {
                String newText =
                    (int.parse(repetitionsController.value.text) - 1)
                        .toString();
                repetitionsController.value = repetitionsController.value
                    .copyWith(
                        text: newText,
                        selection:
                            TextSelection.collapsed(offset: newText.length));
              }
            },
            icon: const Icon(Icons.minimize_outlined)),
        Expanded(
          child: TextFormField(
              controller: repetitionsController,
              decoration: const InputDecoration(labelText: "Repetitions"),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter the number';
                } else if (int.tryParse(value) == null) {
                  return 'You can enter numbers only';
                }
                return null;
              },
              onSaved: (newValue) => onSaved(int.parse(newValue!))),
        ),
        IconButton(
            onPressed: () {
              String newText =
                  (int.parse(repetitionsController.value.text) + 1).toString();
              repetitionsController.value = repetitionsController.value
                  .copyWith(
                      text: newText,
                      selection:
                          TextSelection.collapsed(offset: newText.length));
            },
            icon: const Icon(Icons.add)),
      ],
    );
  }
}
