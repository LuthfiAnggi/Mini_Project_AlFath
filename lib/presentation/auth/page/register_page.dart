import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek
// TODO: Ganti import ini dengan path BLoC Anda yang sebenarnya
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/widget/auth_header_widget.dart';
import 'package:mini_project1/presentation/auth/widget/custom_text_form_field_widget.dart';
import 'package:mini_project1/presentation/auth/widget/form_label_widget.dart';
import 'package:mini_project1/presentation/auth/widget/phone_form_field_widget.dart';

class RegisterPage extends StatefulWidget {
  // Kita akan menerima email dari halaman sebelumnya
  final String email;

  const RegisterPage({super.key, required this.email});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controller untuk setiap field
  late final TextEditingController _emailController;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // State untuk visibilitas password
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    // Isi field email secara otomatis dari data halaman sebelumnya
    _emailController = TextEditingController(text: widget.email);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Method untuk submit registrasi
  void _submitRegister() {
    // Cek apakah form valid
    if (_formKey.currentState!.validate()) {
      // Cek apakah password & konfirmasi password sama
      if (_passwordController.text != _confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Password dan Konfirmasi Password tidak cocok'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }

      // TODO: Panggil BLoC event untuk registrasi
      // Anda perlu membuat event ini di auth_bloc.dart
      /*
      context.read<AuthBloc>().add(
        AuthRegisterPressed(
          email: _emailController.text,
          name: _nameController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );
      */
      print("DATA REGISTRASI SIAP DIKIRIM KE BLOC");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.whiteColor,

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const AuthHeaderWidget(),

                // Label "Email"
                const FormLabelWidget(label: "Email"),
                CustomTextFormFieldWidget(
                  controller: _emailController,
                  hintText: "Masukkan Email",
                  readOnly: true,
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                const SizedBox(height: 8),
                // Teks "Akun telah ditemukan" (dari gambar)
                Text(
                  'Akun telah ditemukan. Silahkan masukkan password',
                  style: TextStyle(color: Colors.green[700], fontSize: 12),
                ),
                const SizedBox(height: 16),

                // Label "Nama Lengkap"
                const FormLabelWidget(label: "Nama Lengkap"),
                CustomTextFormFieldWidget(
                  controller: _nameController,
                  hintText: "Masukkan Nama",
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Nama tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 16),

                // Label "No. HP"
                const FormLabelWidget(label: "No. HP"),
                PhoneFormFieldWidget(
                  controller: _phoneController,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'No. HP tidak boleh kosong'
                      : null,
                ),
                const SizedBox(height: 16),

                // Label "Password"
                const FormLabelWidget(label: "Password"),
                CustomTextFormFieldWidget(
                  controller: _passwordController,
                  hintText: "Masukkan Password",
                  obscureText: !_isPasswordVisible,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Password tidak boleh kosong'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 16),

                // Label "Konfirmasi Password"
                const FormLabelWidget(label: "Konfirmasi Password"),
                CustomTextFormFieldWidget(
                  controller: _confirmPasswordController,
                  hintText: "Masukkan Password",
                  obscureText: !_isConfirmPasswordVisible,
                  validator: (value) => (value == null || value.isEmpty)
                      ? 'Konfirmasi password tidak boleh kosong'
                      : null,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isConfirmPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                      });
                    },
                  ),
                ),
                const SizedBox(height: 32),

                // Tombol Daftar
                // TODO: Bungkus dengan BlocBuilder untuk handle state loading
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConfig.primaryDefault,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text("Daftar", style: ThemeConfig.buttonPrimary),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget helper untuk Label
  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: Theme.of(
          context,
        ).textTheme.bodyMedium?.copyWith(fontWeight: ThemeConfig.semibold),
      ),
    );
  }
}
