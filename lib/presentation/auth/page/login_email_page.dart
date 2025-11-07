import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/page/register_page.dart';
import 'package:mini_project1/presentation/auth/widget/auth_header_widget.dart';
import 'package:mini_project1/presentation/auth/widget/form_label_widget.dart';
import 'package:mini_project1/presentation/auth/widget/custom_text_form_field_widget.dart';

class LoginEmailPage extends StatefulWidget {
  const LoginEmailPage({super.key});

  @override
  State<LoginEmailPage> createState() => _LoginEmailPageState();
}

class _LoginEmailPageState extends State<LoginEmailPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Method untuk memvalidasi email
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email tidak boleh kosong';
    }
    // Regex sederhana untuk validasi email
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Format email tidak valid';
    }
    return null;
  }

  // KOMENTAR: Kita simpan status email di state lokal
  bool _isEmailRegistered = false;

  // KOMENTAR: Method baru untuk submit login
  void _submitLogin() {
    // Validasi bisa ditambahkan di sini jika perlu
    final email = _emailController.text;
    final password = _passwordController.text;

    if (password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password tidak boleh kosong')),
      );
      return;
    }

    // Panggil BLoC event (yang akan kita buat di Langkah 3)
    context.read<AuthBloc>().add(AuthLoginPressed(email, password));
  }

  // Method untuk memicu BLoC
  void _submitCheckEmail() {
    // Cek apakah form valid
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      // Panggil BLoC event
      context.read<AuthBloc>().add(AuthCheckEmailPressed(email));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.whiteColor,
      // Kita gunakan BlocListener untuk mendengarkan perubahan state
      // dan melakukan navigasi atau menampilkan error
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthEmailCheckSuccess) {
            if (state.isRegistered) {
              // 1. Email TERDAFTAR:
              // KOMENTAR: Kita TIDAK pindah halaman.
              // Kita hanya update state lokal & biarkan BlocBuilder bekerja
              setState(() {
                _isEmailRegistered = true;
              });
              // Tampilkan pesan sukses
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Akun telah ditemukan. Silahkan masukkan password',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              // 2. Email BELUM TERDAFTAR: Pergi ke halaman Registrasi
              Navigator.push(
                context,
                MaterialPageRoute(
                  // Kirim email yang diketik pengguna ke halaman registrasi
                  builder: (context) =>
                      RegisterPage(email: _emailController.text),
                ),
              );
            }
          } else if (state is AuthEmailCheckFailure) {
            // 3. JIKA GAGAL CEK EMAIL: Tampilkan Snackbar error
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );

            // KOMENTAR: TAMBAHKAN INI UNTUK LOGIN
          } else if (state is AuthLoginSuccess) {
            // 4. JIKA LOGIN SUKSES
            // TODO: Navigasi ke Halaman Home / Dashboard
            // Navigator.pushAndRemoveUntil( ... ke HomePage ... );
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Login Berhasil!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is AuthLoginFailure) {
            // 5. JIKA LOGIN GAGAL (misal: password salah)
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
          // --------------------------------
        },
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            // KOMENTAR: Kita bungkus Column dengan SingleChildScrollView
            // agar tidak overflow saat keyboard muncul atau saat field password tampil
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // widget header
                  const AuthHeaderWidget(),

                  const FormLabelWidget(label: "Email"),
                  CustomTextFormFieldWidget(
                    controller: _emailController,
                    validator: _validateEmail,
                    keyboardType: TextInputType.emailAddress,
                    readOnly: _isEmailRegistered,
                    hintText: "Masukkan Email",
                  ),

                  // --- KOMENTAR: BLOK UI DINAMIS DIMULAI DI SINI ---
                  // Tampilkan field password HANYA JIKA email sudah terdaftar
                  if (_isEmailRegistered) ...[
                    const SizedBox(height: 8),
                    // Teks "Akun telah ditemukan" (dari gambar)
                    Text(
                      'Akun telah ditemukan. Silahkan masukkan password',
                      style: TextStyle(color: Colors.green[700], fontSize: 12),
                    ),
                    const SizedBox(height: 16),

                    // --- PASSWORD ---
                    const FormLabelWidget(label: "Password"),
                    CustomTextFormFieldWidget(
                      controller: _passwordController,
                      hintText: "Masukkan Password",
                      obscureText: !_isPasswordVisible,
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
                  ],

                  // --- KOMENTAR: BLOK UI DINAMIS SELESAI ---
                  const SizedBox(height: 16),

                  // Tombol Lanjut
                  // Kita gunakan BlocBuilder untuk mengubah tampilan tombol
                  // saat state sedang loading
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      // KOMENTAR: isLoading sekarang mengecek DUA state
                      final isLoading =
                          state is AuthEmailCheckLoading ||
                          state is AuthLoginLoading;

                      // KOMENTAR: Teks & Fungsi tombol sekarang dinamis
                      final String buttonText = _isEmailRegistered
                          ? "Masuk"
                          : "Lanjut";
                      final VoidCallback onPressed = _isEmailRegistered
                          ? _submitLogin
                          : _submitCheckEmail;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // KOMENTAR: Nonaktifkan tombol saat loading
                          onPressed: isLoading ? null : onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeConfig.primaryDefault,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : Text(
                                  buttonText, // <-- Teks dinamis
                                  style: ThemeConfig.buttonPrimary,
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
