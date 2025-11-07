// File: lib/presentation/auth/widget/auth_header_widget.dart

import 'package:flutter/material.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek

class AuthHeaderWidget extends StatelessWidget {
  const AuthHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. Tombol 'X' di sebelah kanan
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.close),
            padding: const EdgeInsets.only(top: 16, bottom: 16),
            onPressed: () => Navigator.pop(context),
            color: ThemeConfig.generalGray, 
          ),
        ),
        const SizedBox(height: 16),

        // 2. Teks Judul (rata kiri)
        Text(
          "Masuk atau Daftar",
          style: Theme.of(context).textTheme.headlineSmall, 
        ),
        const SizedBox(height: 8),

        // 3. Teks Subjudul (rata kiri)
        Text(
          "Silahkan masukkan emailmu untuk melanjutkan",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: ThemeConfig.generalGray,
              ),
        ),
        const SizedBox(height: 24), 
      ],
    );
  }
}