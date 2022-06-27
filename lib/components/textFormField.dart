// ignore_for_file: file_names, non_constant_identifier_names, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class MainTextFormField extends StatelessWidget {
  const MainTextFormField({
    Key? key,
    required this.LabelText,
    required TextEditingController this.ControllerDenetleyici,
    this.obscureText = false,
    this.keytype,
  }) : super(key: key);
  final bool obscureText;
  final String LabelText;
  final ControllerDenetleyici;
  final keytype;
  @override
  Widget build(BuildContext context) {
    //
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Boş bırakamazsın";
        }
        return null;
      },
      keyboardType: keytype,
      obscureText: obscureText,
      controller: ControllerDenetleyici,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xFFFAA885),
          ),
        ),
        contentPadding: const EdgeInsets.fromLTRB(35, 0, 0, 0),
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        labelText: LabelText,
        labelStyle: const TextStyle(
          color: Colors.black45,
        ),
      ),
    );
  }
}
