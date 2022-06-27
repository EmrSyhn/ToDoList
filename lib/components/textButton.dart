// ignore_for_file: file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class MainTextButton extends StatelessWidget {
  const MainTextButton({
    Key? key,
    required this.TextYazisi,
    required this.Press,
    required this.size,
  }) : super(key: key);

  final String TextYazisi;
  final VoidCallback Press;
  final double size;
  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        textStyle: TextStyle(fontSize: size),
      ),
      onPressed: Press,
      child: Text(TextYazisi,
          style: const TextStyle(
              color: Color(0xFFAD491E), fontWeight: FontWeight.bold)),
    );
  }
}
