import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showNewEntryDialog({
  required BuildContext context,
  bool isWorkout = true,
  required void Function(String name) onSaveClicked,
}) {
  final form = GlobalKey<FormState>();
  String name = '';
  String title = 'New Exercise';
  if (isWorkout) {
    title = 'New Program';
  }
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      contentPadding: const EdgeInsets.all(20),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.close))
        ],
      ),
      children: [
        Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: "Name"),
                textCapitalization: TextCapitalization.sentences,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the name';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value!;
                },
              ),
              const SizedBox(height: 15),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        Theme.of(context).colorScheme.primaryContainer,
                  ),
                  onPressed: () {
                    final isValid = form.currentState!.validate();
                    if (!isValid) {
                      return;
                    }
                    form.currentState!.save();
                    onSaveClicked(name);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

void showWarningAlertDialog({
  required BuildContext context,
  required String text,
  required void Function() onYesClicked,
}) {
  if (Platform.isIOS) {
    showCupertinoDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text("Warning!"),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: onYesClicked,
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  } else {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text("Warning!"),
        titleTextStyle: Theme.of(context)
            .textTheme
            .titleLarge!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
        contentTextStyle: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
        content: Text(text),
        actions: [
          TextButton(
            onPressed: onYesClicked,
            child: const Text("Yes"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
            },
            child: const Text("No"),
          ),
        ],
      ),
    );
  }
}
