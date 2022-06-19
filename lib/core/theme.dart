import 'package:flutter/material.dart';

class Themes {
  static final light = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.light,
  );
  static final dark = ThemeData(
    primarySwatch: Colors.indigo,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(color: Colors.indigo),
  );
}
