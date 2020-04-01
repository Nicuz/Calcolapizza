import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    accentColor: Color(0xffc33c54),
    cursorColor: Colors.black,
    textSelectionHandleColor: Color(0xffc33c54),
    primarySwatch: MaterialColor(4290985044, {
      50: Color(0xfff9ebee),
      100: Color(0xfff3d8dd),
      200: Color(0xffe7b1bb),
      300: Color(0xffdb8a98),
      400: Color(0xffcf6376),
      500: Color(0xffc33c54),
      600: Color(0xff9c3043),
      700: Color(0xff752432),
      800: Color(0xff4e1822),
      900: Color(0xff270c11)
    }),
    scaffoldBackgroundColor: Color(0xffEFEFEF),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.black,
      ),
      elevation: 0.0,
    ),
    bottomAppBarColor: Color(0xffc33c54),
    cardColor: Colors.white,
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xffc33c54),
      thumbColor: Color(0xffc33c54),
      inactiveTrackColor: Color(0xffd2acb0),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff121212),
    cardColor: Color(0xff272727),
    accentColor: Color(0xff38ada9),
    cursorColor: Colors.white,
    textSelectionHandleColor: Color(0xff38ada9),
    primarySwatch: MaterialColor(4290985044, {
      50: Color(0xfff9ebee),
      100: Color(0xfff3d8dd),
      200: Color(0xffe7b1bb),
      300: Color(0xffdb8a98),
      400: Color(0xffcf6376),
      500: Color(0xffc33c54),
      600: Color(0xff9c3043),
      700: Color(0xff752432),
      800: Color(0xff4e1822),
      900: Color(0xff270c11)
    }),
    appBarTheme: AppBarTheme(
      color: Colors.transparent,
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
      elevation: 0.0,
    ),
    bottomAppBarColor: Color(0xff343434),
    sliderTheme: SliderThemeData(
      activeTrackColor: Color(0xff38ada9),
      thumbColor: Color(0xff38ada9),
      inactiveTrackColor: Color(0xff156461),
    ),
  );

  static Color bottombarActiveColor = Colors.white;
  static Color bottombarInactiveColor = Color(0xffEFEFEF);
}
