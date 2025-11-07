// File: lib/presentation/auth/widget/phone_form_field_widget.dart

import 'package:flutter/material.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek
import 'package:mini_project1/gen/assets.gen.dart';      // Ganti nama proyek

class PhoneFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String? Function(String?)? validator;

  const PhoneFormFieldWidget({
    super.key,
    required this.controller,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: TextInputType.phone,
      decoration: InputDecoration(
        hintText: "81234567890",

        // Mengatur border
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ThemeConfig.generalGray.withOpacity(0.3),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: ThemeConfig.generalGray.withOpacity(0.3),
          ),
        ),

        // --- INI BAGIAN PENTING UNTUK +62 ---
        prefixIcon: Container(
          // Atur padding di dalam prefix
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          margin: const EdgeInsets.only(right: 12),

          // Beri background abu-abu muda dan garis kanan
          decoration: BoxDecoration(
            color: Colors.grey[50],
            border: Border(
              right: BorderSide(
                color: ThemeConfig.generalGray.withOpacity(0.3),
              ),
            ),
            // (Radius di sini harus cocok dengan border,
            // tapi karena ada garis kanan, kita tidak perlu set radius)
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // Agar container-nya pas
            children: [
              // TODO: Ganti ini dengan aset bendera Anda
              Assets.images.imgIndonesia.image(width: 16,height: 12), 
              const SizedBox(width: 8),
              Text(
                '+62',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        // ------------------------------------
      ),
    );
  }
}