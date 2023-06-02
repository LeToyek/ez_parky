import 'package:ez_parky/view/theme/color.dart';
import 'package:ez_parky/view/theme/elevated_button_theme.dart';
import 'package:ez_parky/view/theme/input_decoration_theme.dart';
import 'package:ez_parky/view/theme/text_theme.dart';
import 'package:flutter/material.dart';

ThemeData ezThemeData = ThemeData(
  inputDecorationTheme: ezInputTheme,
  elevatedButtonTheme: ezElevatedButtonTheme,
  textTheme: ezTextTheme,
  primaryColor: ezBlue,
  primaryColorDark: ezBlueDark,
  primaryColorLight: ezBlueLight,
  appBarTheme: const AppBarTheme(
    color: ezBlue,
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: Colors.white,
    selectedItemColor: ezBlue,
    unselectedItemColor: Colors.grey,
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: ezBlue,
    textTheme: ButtonTextTheme.primary,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(secondary: ezBlueAccent),
);
