import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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