import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField({
    super.key,
    required this.isDouble,
    required this.onSaved,
  });

  final bool isDouble;
  final ValueChanged<String> onSaved;

  @override
  Widget build(BuildContext context) {
    final repetitionsController =
        TextEditingController(text: isDouble ? '0.0' : '0');
    return Row(
      children: [
        IconButton(
          onPressed: () {
            if (repetitionsController.text != '0' &&
                repetitionsController.text != '0.0') {
              String newText = (isDouble
                      ? (double.parse(repetitionsController.value.text) - 0.5)
                      : (int.parse(repetitionsController.value.text) - 1))
                  .toString();
              repetitionsController.value = repetitionsController.value
                  .copyWith(
                      text: newText,
                      selection:
                          TextSelection.collapsed(offset: newText.length));
            }
          },
          icon: const Icon(Icons.minimize_outlined),
        ),
        Expanded(
          child: TextFormField(
            controller: repetitionsController,
            decoration: InputDecoration(
              labelText: isDouble ? 'Weight' : "Repetitions",
            ),
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == '0' || value == '0.0' || value!.trim().isEmpty) {
                return 'Cannot be 0';
              }
              if ((isDouble && double.tryParse(value) == null) ||
                  (!isDouble && int.tryParse(value) == null)) {
                return 'You can enter numbers only';
              }
              return null;
            },
            onSaved: (newValue) => onSaved(newValue!),
          ),
        ),
        IconButton(
          onPressed: () {
            String newText = (isDouble
                    ? (double.parse(repetitionsController.value.text) + 0.5)
                    : (int.parse(repetitionsController.value.text) + 1))
                .toString();
            repetitionsController.value = repetitionsController.value.copyWith(
                text: newText,
                selection: TextSelection.collapsed(offset: newText.length));
          },
          icon: const Icon(Icons.add),
        ),
      ],
    );
  }
}
