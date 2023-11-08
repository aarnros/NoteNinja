import 'package:flutter/material.dart';

const colorPrimary = Color.fromARGB(255, 243, 255, 235);
const colorAccent = Color.fromARGB(255, 255, 166, 158);
const colorBar = Color.fromARGB(255, 13, 93, 86);

ThemeData defaultTheme = ThemeData(
  primaryColor: colorPrimary,
  floatingActionButtonTheme:
      FloatingActionButtonThemeData(backgroundColor: colorAccent),
  appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(color: Colors.black), color: colorBar),
  scaffoldBackgroundColor: colorPrimary,
);
