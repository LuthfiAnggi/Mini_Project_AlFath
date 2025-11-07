// File: lib/presentation/auth/widget/form_label_widget.dart

import 'package:flutter/material.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek

class FormLabelWidget extends StatelessWidget {
  final String label;

  const FormLabelWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
              fontWeight: ThemeConfig.regular,
            ),
      ),
    );
  }
}