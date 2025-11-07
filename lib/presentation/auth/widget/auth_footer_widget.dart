import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek

class AuthFooterWidget extends StatelessWidget {
  const AuthFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // PASTE KODE ANDA (return Text.rich...) DI SINI
    return Text.rich(
      TextSpan(
        // Style default untuk teks footer
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: ThemeConfig.generalGray),
        children: [
          const TextSpan(text: "Dengan mendaftar, Saya menyetujui\n"),
          TextSpan(
            text: "Syarat dan Ketentuan",
            // Style untuk link
            style: const TextStyle(
              color: ThemeConfig.primaryDefault,
              fontWeight: ThemeConfig.semibold,
            ),
            // Ini untuk membuat teks bisa di-klik
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Aksi saat "Syarat dan Ketentuan" di-klik
                print("Buka Syarat dan Ketentuan");
              },
          ),
          const TextSpan(text: " yang berlaku dan "),
          TextSpan(
            text: "Kebijakan Privasi",
            // Style untuk link
            style: const TextStyle(
              color: ThemeConfig.primaryDefault,
              fontWeight: ThemeConfig.semibold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Aksi saat "Kebijakan Privasi" di-klik
                print("Buka Kebijakan Privasi");
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
