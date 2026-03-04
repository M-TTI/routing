import 'package:flutter/material.dart';

const pink = Color(0xFFFF2E7E);
const pinkHover = Color(0xFF9E3158);
const pinkPressed = Color(0xFFFF6BA3);
const lightPrimary = Color(0xFFF5CEDB);
const darkPrimary = Color(0xFF433D56);
const error = Color(0xFFE12D39);
const white = Color(0xFFFFFFFF);
const black = Color(0xFF000000);
const shadow = Color(0x40000000);
const grey = Color(0xFF757575);
const border = Color(0xFFBDBDBD);
const skeleton = Color(0xFFC7B9B9);
const skeletonDark = Color(0xFF524A5C);
const placeholder = Color(0xFF737183);

const cardShadow = [
  BoxShadow(
    offset: Offset(0, 4),
    blurRadius: 4,
    color: shadow,
  ),
];

final _buttonStyle = ButtonStyle(
  backgroundColor: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) return pinkPressed;
    if (states.contains(WidgetState.hovered)) return pinkHover;
    return pink;
  }),
  foregroundColor: WidgetStateProperty.all(white),
  shape: WidgetStateProperty.all(
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  ),
  elevation: WidgetStateProperty.resolveWith((states) {
    if (states.contains(WidgetState.pressed)) return 2;
    return 4;
  }),
  padding: WidgetStateProperty.all(
    const EdgeInsets.symmetric(horizontal: 16),
  ),
  minimumSize: WidgetStateProperty.all(
    const Size(0, 40),
  ),
);

ThemeData buildTheme(Brightness brightness) {
  final isLight = brightness == Brightness.light;
  return ThemeData(
    brightness: brightness,
    colorScheme: ColorScheme(
      brightness: brightness,
      primary: pink,
      onPrimary: white,
      primaryContainer: isLight ? lightPrimary : darkPrimary,
      onPrimaryContainer: isLight ? darkPrimary : lightPrimary,
      secondaryContainer: isLight ? skeleton : skeletonDark,
      error: error,
      onError: white,
      surface: isLight ? lightPrimary : darkPrimary,
      onSurface: isLight ? black : white,
      onSurfaceVariant: isLight ? grey : border,
      outline: border,
      secondary: pink,
      onSecondary: white,
    ),
    fontFamily: 'Inter',
    filledButtonTheme: FilledButtonThemeData(style: _buttonStyle),
    elevatedButtonTheme: ElevatedButtonThemeData(style: _buttonStyle),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: pink,
      foregroundColor: white,
    ),
  );
}
