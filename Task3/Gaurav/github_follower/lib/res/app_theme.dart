import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color falcon50 = Color(0xFFF9F6F8);
  static const Color falcon100 = Color(0xFFF4EFF2);
  static const Color falcon200 = Color(0xFFEBDFE7);
  static const Color falcon300 = Color(0xFFDBC6D3);
  static const Color falcon400 = Color(0xFFC4A2B7);
  static const Color falcon500 = Color(0xFFB0849E);
  static const Color falcon600 = Color(0xFF996983);
  static const Color falcon700 = Color(0xFF85586F);
  static const Color falcon800 = Color(0xFF6C485A);
  static const Color falcon900 = Color(0xFF5C3F4E);
  static const Color falcon950 = Color(0xFF35222C);

  static ThemeData get themeData {
    return ThemeData(
        primaryColor: falcon300,
        scaffoldBackgroundColor: falcon200,
        appBarTheme:  const AppBarTheme(
          backgroundColor: falcon500,
          centerTitle: true,
          titleTextStyle: TextStyle(color: falcon100, fontSize: 20),
          
        ),
        
        textTheme: GoogleFonts.ubuntuTextTheme(
          const TextTheme(
          displayLarge: TextStyle(color: falcon950, fontWeight: FontWeight.bold),
          titleLarge: TextStyle(color: falcon950, fontWeight: FontWeight.w500),
          titleMedium: TextStyle(color: falcon950),
          bodyMedium: TextStyle(color: falcon950),
          bodyLarge: TextStyle(color: falcon900),
          )
        ),
        
        iconTheme: const IconThemeData(color: falcon900,size: 25),

        colorScheme: ColorScheme.fromSwatch().copyWith(
        primary: falcon300,
        secondary: falcon400,
        surface: falcon50,
        brightness: Brightness.light
      ));
  }
}
