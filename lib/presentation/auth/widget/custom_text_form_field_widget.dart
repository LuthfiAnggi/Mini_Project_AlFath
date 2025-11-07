// File: lib/presentation/auth/widget/custom_text_form_field_widget.dart

import 'package:flutter/material.dart';

class CustomTextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final bool readOnly;
  final Widget? suffixIcon;
  final bool filled;
  final Color? fillColor;

  const CustomTextFormFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.readOnly = false,
    this.suffixIcon,
    this.filled = false, // Default-nya false
    this.fillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      readOnly: readOnly,
      obscureText: obscureText,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        // Jika kita mengirim suffixIcon, tampilkan
        suffixIcon: suffixIcon,

        filled: filled,
        fillColor: fillColor,
      ),
    );
  }
}
