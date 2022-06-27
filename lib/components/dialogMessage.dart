// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

void dialogMesaj(BuildContext context, {String msg = ''}) {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: const Text("Hata"),
      content: Text(msg),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(ctx).pop();
          },
          child: const Text("Kapat"),
        ),
      ],
    ),
  );
}
