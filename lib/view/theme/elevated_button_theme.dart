import 'package:flutter/material.dart';

var ezElevatedButtonTheme = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12.0),
    ),
    padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
    textStyle: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
    ),
  ),
);
