import 'package:flutter/material.dart';

class NumberTextField extends StatelessWidget {
  const NumberTextField(
      {super.key,
      required this.isDouble,
      required this.onSaved,
      this.inputDecoration,
      this.initialValue});

  final bool isDouble;
  final ValueChanged<String> onSaved;
  final InputDecoration? inputDecoration;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    final repetitionsController =
        TextEditingController(text: initialValue);
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
        Flexible(
          child: TextFormField(
            controller: repetitionsController,
            decoration: inputDecoration,
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
