  // -----------------------------------------------------------------
// WIDGET BACKGROUND
// -----------------------------------------------------------------
import 'package:flutter/material.dart';
import 'package:mini_project1/config/theme_config.dart';
import 'package:mini_project1/gen/assets.gen.dart';

class AuthBackgroundWidget extends StatelessWidget {
  const AuthBackgroundWidget();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 731, // Tinggi spesifik dari Figma
        width: double.infinity,

        // 1. Latar belakang sekarang adalah WARNA SOLID
        // color: const Color(0xff2DA3D6),
        color: ThemeConfig.primaryDefault,

        // 2. Tampilkan ilustrasi DI ATAS background
        //    Kita gunakan Center agar gambar ada di tengah
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 10,
              bottom: 150,
            ), // Atur padding di sini
            // GANTI 'child' DENGAN STACK BARU INI
            child: Stack(
              alignment: Alignment.center,
              children: [
                // 1. Lapisan Bawah: Gambar Anda
                Assets.images.imgLogin.image(fit: BoxFit.contain),

                // 2. Lapisan Atas: Overlay Anda
                Container(
                  // Ini adalah warna overlay Anda
                  color: const Color(0xff0F172A).withOpacity(0.8),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}