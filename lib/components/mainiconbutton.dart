import 'package:flutter/material.dart';

class MainIconButton extends StatelessWidget {
  const MainIconButton(
      {Key? key,
      //tanımlanan zorunlu fonksiyonlar
      required this.iconsecici,
      required this.press})
      : super(key: key);
  //butona tanımlanan isimler
  final VoidCallback press;
  final IconData iconsecici;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: press,
      icon: Icon(iconsecici),
    );
  }
}
