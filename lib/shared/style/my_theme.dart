import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app3/shared/style/colors.dart';

class MyTheme {
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffDFECDB),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
    // textTheme: TextTheme(
    //   bodyLarge: GoogleFonts.elMessiri(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 15,
    //     color: Colors.black,
    //   ),
    //   bodyMedium: GoogleFonts.elMessiri(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 15,
    //     color: Colors.black,
    //   ),
    //   bodySmall: GoogleFonts.elMessiri(
    //     fontWeight: FontWeight.bold,
    //     fontSize: 15,
    //     color: Colors.black,
    //   ),
    // ),
  );
  static ThemeData darkTheme = ThemeData();
}
