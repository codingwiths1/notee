import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: AppColor.backgroundColor,
  textTheme: GoogleFonts.poppinsTextTheme().copyWith(
    bodyMedium: const TextStyle(fontSize: 16),
  ),
);

class AppColor {
  static Color? backgroundColor = const Color(0xffffffff);
  static Color white = const Color(0xffffffff);
  static Color secondaryColor = const Color(0xfff0f3fa);
  static Color transparant = const Color(0x00000000);
  static Color black = const Color(0xff000000);
  static Color? grey700 = Colors.grey[700];
  static Color? grey400 = Colors.grey[400];
  static Color? red = Colors.red;

  static Color blue = const Color(0xff605bff);
}
