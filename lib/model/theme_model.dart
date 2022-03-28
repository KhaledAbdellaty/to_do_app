

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Themes{
  static final light = ThemeData(
      primarySwatch: Colors.indigo,
      brightness: Brightness.light

  );
  static final dark = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(color: Colors.indigo),
  );
}
TextStyle get subHeadingStyle{

  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,

    ),
  );
}
TextStyle get headingStyle{
  return GoogleFonts.lato (
    textStyle: const TextStyle(
      fontSize: 30,
      fontWeight: FontWeight.bold,

    ),
  );
}