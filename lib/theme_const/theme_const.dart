import 'package:flutter/material.dart';

const colorPrimary = Color.fromARGB(255, 237, 246, 249);
const colorAccent = Color.fromARGB(255, 131, 197, 191);
const colorBar = Color.fromARGB(255, 0, 109, 119);

ThemeData defaultTheme = ThemeData(
  primaryColor: colorPrimary,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: colorAccent),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black), color: colorBar),
  scaffoldBackgroundColor: colorPrimary,
);
