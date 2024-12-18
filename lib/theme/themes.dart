import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'colors.dart';

ThemeData themeData(){
  return ThemeData(
    primaryColor: Color(0xFF8FAEF2),
    primaryColorLight: Color(0xFFFFFFFF),
    primaryColorDark: Color(0xFF000000),
    highlightColor: Color(0xFFF3F3F7),

    inputDecorationTheme: InputDecorationTheme(
      contentPadding: const EdgeInsets.all(8),
      hintStyle: const TextStyle(color: Color(0xFF7c7e7d), fontWeight: FontWeight.normal, fontSize: 16),
      labelStyle: const TextStyle(color: Color(0xFF7c7e7d), fontWeight: FontWeight.normal, fontSize: 16),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(width: 0,color: Colors.white,),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        borderSide: BorderSide(width: 0,color: Colors.white),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0,color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      disabledBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0,color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0,color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 0.5,color: Colors.white),
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),

      filled: true,
      fillColor: Colors.grey[100],
      floatingLabelBehavior: FloatingLabelBehavior.auto,
    ),
    primaryTextTheme: TextTheme(
      headlineMedium: GoogleFonts.poppins(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 18),
      headlineSmall: GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500, letterSpacing: 0.2, color: Colors.black),
      headlineLarge: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 50),
      titleMedium: GoogleFonts.poppins(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500),
      titleLarge: TextStyle(color: Color(0xFF7c7e7d), fontWeight: FontWeight.normal, fontSize: 16),
      titleSmall: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
    ),
    scaffoldBackgroundColor: Colors.white,
    dividerTheme: const DividerThemeData(color: Colors.black38),
    dialogTheme: DialogTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.black, fontSize: 20),
      color: Colors.transparent,
      elevation: 0,
      actionsIconTheme: IconThemeData(color: Colors.white, size: 30),
      iconTheme: IconThemeData(color: Color(0XFF1875D3), size: 30),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Color(0xFF8FAEF2)),
        elevation: MaterialStateProperty.all(0.5),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
        padding: MaterialStateProperty.all(EdgeInsets.all(5)),
      ),

    ),
  );
}