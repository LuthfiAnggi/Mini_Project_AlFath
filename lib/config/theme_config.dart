import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:mini_project1/gen/fonts.gen.dart'; 
import 'package:mini_project1/gen/fonts.gen.dart';

class ThemeConfig {
  // -------------------------------------------------------------------
  // 1. SEMUA WARNA KINI ADA DI DALAM CLASS SEBAGAI 'static const'
  // -------------------------------------------------------------------
  static const Color whiteColor = Color(0xffFFFFFF);
  static const Color blackColor = Color(0xff14193f);
  static const Color blueColor = Color(0xff2DA3D6);
  static const Color lightblueColor = Color(0xffF0FFFF);
  static const Color lightBackgroundColor = Color(0xffF6F8FB);
  static const Color darkBackgroundColor = Color(0xff020518);
  static const Color purpleColor = Color(0xff5142E6);
  static const Color greenColor = Color(0xff22B07D);
  static const Color numberBackgroundColor = Color(0xff1A1D2E);

  // color onboarding page
  static const Color primaryDefault = Color(0xff2DA3D6);
  static const Color primaryDefaultStrong = Color(0xff2080B8);
  static const Color generalGray = Color(0xff6974AA);

  //color login page
  static const Color generalPlaceholder = Color(0xffB0BBE5);
  static const Color successDefault = Color(0xff38C43D);
  static const Color primaryBGWeak = Color(0xffF0FFFF);
  static const Color generalBlack = Color(0xff0F172A);
  static const Color generalBody = Color(0xff141A51);

  // -------------------------------------------------------------------
  // 2. SEMUA FONT WEIGHT KINI ADA DI DALAM CLASS SEBAGAI 'static const'
  // -------------------------------------------------------------------
  static const FontWeight light = FontWeight.w300;
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
  static const FontWeight extrabold = FontWeight.w800;
  static const FontWeight black = FontWeight.w900;

  // -------------------------------------------------------------------
  // 3. SEMUA TEXT STYLE KINI ADA DI DALAM CLASS SEBAGAI 'static'
  //    (Referensi ke warna/weight di atas kini otomatis)
  // -------------------------------------------------------------------
  static TextStyle blackTextStyle = GoogleFonts.poppins(
    color: blackColor, // Mengambil 'blackColor' dari class ini
  );

  static TextStyle whiteTextStyle = GoogleFonts.poppins(
    color: whiteColor, // Mengambil 'whiteColor' dari class ini
  );

  static TextStyle blueTextStyle = GoogleFonts.poppins(
    color: blueColor, // Mengambil 'blueColor' dari class ini
  );

  static TextStyle onboardingTitleStyle = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: semibold, // Mengambil 'semibold' dari class ini
    color: primaryDefaultStrong,   // Mengambil 'blackColor' dari class ini
    fontSize: 32,
    letterSpacing: -1.0,
    height: 1.25,
  );

  static TextStyle authTitleStyle = TextStyle(
    fontFamily: FontFamily.inter,
    fontWeight: semibold, // Mengambil 'semibold' dari class ini
    color: generalBlack,   // Mengambil 'blackColor' dari class ini
    fontSize: 24,
    letterSpacing: -0.4,
    height: 1.3,
  );

  static TextStyle onboardingSubtitleStyle = TextStyle(
    fontFamily: FontFamily.inter, //poppins
    fontWeight: regular,     // Mengambil 'regular' dari class ini
    color: generalGray,  // Mengambil 'generalGray' dari class ini
    fontSize: 14,
    height: 1.5,
  );

  static TextStyle loginlabelStyle = TextStyle(
    fontFamily: FontFamily.inter, //poppins
    fontWeight: regular,     // Mengambil 'regular' dari class ini
    color: generalBody,  // Mengambil 'generalGray' dari class ini
    fontSize: 14,
    height: 1.5,
  );


  static TextStyle get buttonPrimary {
    return TextStyle(
      fontFamily: FontFamily.inter, // Pastikan fonts.gen.dart sudah di-import
      fontSize: 14,
      fontWeight: ThemeConfig.medium,
      color: ThemeConfig.whiteColor, 
    );
  }

  // Untuk tombol sekunder (TextButton, teks biru)
  static TextStyle get buttonSecondary {
    return TextStyle(
      fontFamily: FontFamily.inter, // Pastikan fonts.gen.dart sudah di-import
      fontSize: 14,
      fontWeight: ThemeConfig.medium,
      color: ThemeConfig.primaryDefault, 
    );
  }


  static TextStyle get buttonLoginOption {
    return TextStyle(
      fontFamily: FontFamily.inter, // Pastikan fonts.gen.dart sudah di-import
      fontSize: 14,
      fontWeight: ThemeConfig.medium,
      color: ThemeConfig.generalBlack, 
    );
  }

  // -------------------------------------------------------------------
  // 4. MEMBUAT THEME DATA (Seperti teman Anda)
  // -------------------------------------------------------------------
  static ThemeData lightMode = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    scaffoldBackgroundColor: whiteColor,
    primaryColor: primaryDefault,
    appBarTheme: AppBarTheme(
      backgroundColor: whiteColor,
      elevation: 0,
      titleTextStyle: blackTextStyle.copyWith(
        fontWeight: bold, 
        fontSize: 20
      ),
      iconTheme: IconThemeData(color: blackColor),
    ),
    textTheme: TextTheme(
      // Kita petakan style kita ke textTheme Flutter
      headlineSmall: authTitleStyle,
      titleLarge: onboardingTitleStyle,     // Style Judul Utama
      bodyMedium: onboardingSubtitleStyle,   // Style Teks Body
      labelLarge: blackTextStyle.copyWith(   // Style Tombol
        fontWeight: bold, 
        fontSize: 16
      ), 
      labelMedium: loginlabelStyle
      // Anda bisa tambahkan sisanya di sini
      // titleMedium: ...
      // titleSmall: ...
      // labelMedium: ...
    ),
  );
}