import 'package:enem_app/core/themes/app_color.dart';
import 'package:enem_app/core/themes/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData get enemTheme => ThemeData(
    brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColor.background,
        fontFamily: GoogleFonts.poppins().fontFamily,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColor.primary,
          titleTextStyle: AppTextStyle.poppinsW800s24,
          centerTitle: true,
        ),
        primaryColor: AppColor.primary,
        useMaterial3: true,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
            overlayColor: WidgetStatePropertyAll(AppColor.black),
            textStyle: WidgetStatePropertyAll(AppTextStyle.poppinsW600s16),
            backgroundColor: WidgetStatePropertyAll(AppColor.primary),
          ),
        ),
      );
}
