// ignore_for_file: file_names

import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

class AnalogSaat extends StatelessWidget {
  const AnalogSaat({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnalogClock(
      decoration: const BoxDecoration(boxShadow: [
        BoxShadow(
          color: Color(0xffBCB9B9),
          blurRadius: 4,
          offset: Offset(4, 8), // Shadow position
        ),
      ], color: Color(0xffFFECE4), shape: BoxShape.circle),
      width: 100,
      height: 120,
      isLive: true,
      secondHandColor: const Color(0xFFBCB9B9),
      hourHandColor: const Color(0xFFBE4713),
      minuteHandColor: const Color(0xFFD36232),
      showSecondHand: true,
      numberColor: const Color(0xFFBE4713),
      showNumbers: true,
      textScaleFactor: 1.3,
      showTicks: false,
      showDigitalClock: false,
      datetime: DateTime.now(),
    );
  }
}
