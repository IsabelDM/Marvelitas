import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Colors {

  const Colors();

  static const Color loginGradientStart = const Color.fromRGBO(0, 0, 0, 100);
  static const Color loginGradientEnd = const Color.fromRGBO(0, 0, 0, 70);
  static const Color colorRojo = const Color.fromRGBO(237, 29, 36, 100);

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}