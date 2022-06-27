import 'package:flutter/material.dart';

class MainButton extends StatelessWidget {
  MainButton({
    Key? key,
    required this.press,
    required this.text,
  }) : super(key: key);

  final buttonstyle = ElevatedButton.styleFrom(
    primary: const Color(0xFFFAA885),
    minimumSize: const Size(310, 55), // background
  );
  final VoidCallback press;
  final String text;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: buttonstyle,
      onPressed: press,
      child: Text(text, style: const TextStyle(fontSize: 20)),
    );
  }
}
