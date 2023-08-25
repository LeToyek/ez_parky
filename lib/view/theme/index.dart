import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const int _primaryColor = 0xFF26C486; // New primary color: Green 26C486
const MaterialColor primarySwatch = MaterialColor(_primaryColor, <int, Color>{
  50: Color(0xFFE0F7E5),
  100: Color(0xFFB3E8C9),
  200: Color(0xFF80D5AA),
  300: Color(0xFF4DC289),
  400: Color(0xFF26C486), // New primary color for 400
  500: Color(_primaryColor), // New primary color for 500
  600: Color(0xFF229D75),
  700: Color(0xFF1D8B66),
  800: Color(0xFF187A57),
  900: Color(0xFF146848),
});

const int _textColor = 0xFF64748B;
const MaterialColor textSwatch = MaterialColor(_textColor, <int, Color>{
  50: Color(0xFFF8FAFC),
  100: Color(0xFFF1F5F9),
  200: Color(0xFFE2E8F0),
  300: Color(0xFFCBD5E1),
  400: Color(0xFF94A3B8),
  500: Color(_textColor),
  600: Color(0xFF475569),
  700: Color(0xFF334155),
  800: Color(0xFF1E293B),
  900: Color(0xFF0F172A),
});

const Color errorColor = Color(0xFFDC2626); // red-600

final ColorScheme lightColorScheme = ColorScheme.light(
  primary: primarySwatch.shade500,
  secondary: primarySwatch.shade500,
  onSecondary: Colors.white,
  error: errorColor,
  background: textSwatch.shade200,
  onBackground: textSwatch.shade500,
  onSurface: textSwatch.shade500,
  surface: textSwatch.shade50,
  surfaceVariant: Colors.white,
  shadow: textSwatch.shade900.withOpacity(.1),
);

final ColorScheme darkColorScheme = ColorScheme.dark(
  primary: primarySwatch.shade500,
  secondary: primarySwatch.shade500,
  onSecondary: Colors.white,
  error: errorColor,
  background: const Color(0xFF171724),
  onBackground: textSwatch.shade400,
  onSurface: textSwatch.shade300,
  surface: const Color(0xFF262630),
  surfaceVariant: const Color(0xFF282832),
  shadow: textSwatch.shade900.withOpacity(.2),
);

final ThemeData lightTheme = ThemeData(
  colorScheme: lightColorScheme,
  fontFamily: GoogleFonts.nunito().fontFamily,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.nunito(
      color: textSwatch.shade700,
    ),
    displayMedium: GoogleFonts.nunito(
      color: textSwatch.shade600,
    ),
    displaySmall: GoogleFonts.nunito(
      color: textSwatch.shade500,
    ),
    headlineLarge: GoogleFonts.nunito(
      color: textSwatch.shade700,
    ),
    headlineMedium: GoogleFonts.nunito(
      color: textSwatch.shade600,
    ),
    headlineSmall: GoogleFonts.nunito(
      color: textSwatch.shade500,
    ),
    titleLarge: GoogleFonts.nunito(
      color: textSwatch.shade700,
    ),
    titleMedium: GoogleFonts.nunito(
      color: textSwatch.shade600,
    ),
    titleSmall: GoogleFonts.nunito(
      color: textSwatch.shade500,
    ),
    bodyLarge: GoogleFonts.nunito(
      color: textSwatch.shade700,
    ),
    bodyMedium: GoogleFonts.nunito(
      color: textSwatch.shade600,
    ),
    bodySmall: GoogleFonts.nunito(
      color: textSwatch.shade500,
    ),
    labelLarge: GoogleFonts.nunito(
      color: textSwatch.shade700,
    ),
    labelMedium: GoogleFonts.nunito(
      color: textSwatch.shade600,
    ),
    labelSmall: GoogleFonts.nunito(
      color: textSwatch.shade500,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
  ),
);

final ThemeData darkTheme = lightTheme.copyWith(
  colorScheme: darkColorScheme,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.nunito(
      color: textSwatch.shade200,
    ),
    displayMedium: GoogleFonts.nunito(
      color: textSwatch.shade300,
    ),
    displaySmall: GoogleFonts.nunito(
      color: textSwatch.shade400,
    ),
    headlineLarge: GoogleFonts.nunito(
      color: textSwatch.shade200,
    ),
    headlineMedium: GoogleFonts.nunito(
      color: textSwatch.shade300,
    ),
    headlineSmall: GoogleFonts.nunito(
      color: textSwatch.shade400,
    ),
    titleLarge: GoogleFonts.nunito(
      color: textSwatch.shade200,
    ),
    titleMedium: GoogleFonts.nunito(
      color: textSwatch.shade300,
    ),
    titleSmall: GoogleFonts.nunito(
      color: textSwatch.shade400,
    ),
    bodyLarge: GoogleFonts.nunito(
      color: textSwatch.shade200,
    ),
    bodyMedium: GoogleFonts.nunito(
      color: textSwatch.shade300,
    ),
    bodySmall: GoogleFonts.nunito(
      color: textSwatch.shade400,
    ),
    labelLarge: GoogleFonts.nunito(
      color: textSwatch.shade200,
    ),
    labelMedium: GoogleFonts.nunito(
      color: textSwatch.shade300,
    ),
    labelSmall: GoogleFonts.nunito(
      color: textSwatch.shade400,
    ),
  ),
  switchTheme: SwitchThemeData(
    thumbColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
    trackColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
  ),
  radioTheme: RadioThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
  ),
  checkboxTheme: CheckboxThemeData(
    fillColor:
        MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
      if (states.contains(MaterialState.disabled)) {
        return null;
      }
      if (states.contains(MaterialState.selected)) {
        return primarySwatch.shade500;
      }
      return null;
    }),
  ),
);
