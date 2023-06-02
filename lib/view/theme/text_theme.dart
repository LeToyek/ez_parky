import 'package:ez_parky/view/theme/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var ezTextTheme = TextTheme(
  displayLarge: GoogleFonts.nunito(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  displayMedium: GoogleFonts.nunito(
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  bodyLarge: GoogleFonts.nunito(
    fontSize: 16.0,
    color: Colors.black,
  ),
  bodyMedium: GoogleFonts.nunito(
    fontSize: 14.0,
    color: Colors.black,
  ),
  labelLarge: GoogleFonts.nunito(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  ),
  titleMedium: GoogleFonts.nunito(
    fontSize: 14.0,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  ),
  titleSmall: GoogleFonts.nunito(
    fontSize: 12.0,
    color: Colors.grey,
  ),
  bodySmall: GoogleFonts.nunito(
    fontSize: 12.0,
    color: Colors.grey,
  ),
  labelSmall: GoogleFonts.nunito(
    fontSize: 10.0,
    fontWeight: FontWeight.bold,
    color: ezBlue,
  ),
);
