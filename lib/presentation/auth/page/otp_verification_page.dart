// File: lib/presentation/auth/page/otp_verification_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/page/login_page.dart';
import 'package:mini_project1/presentation/work/page/work_page.dart';
import 'package:pinput/pinput.dart';

class OtpVerificationPage extends StatefulWidget {
  final String email;
  const OtpVerificationPage({super.key, required this.email});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  final _pinController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  void _submitOtp() {
  if (_formKey.currentState!.validate()) {
    final otp = _pinController.text;
    context.read<AuthBloc>().add(
          AuthVerifyOtpPressed(otp: otp), // <-- HANYA PERLU OTP
        );
  }
}

  void _resendOtp() {
    // Panggil BLoC untuk kirim ulang
    context.read<AuthBloc>().add(AuthSendOtpEmailPressed(email: widget.email));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Mengirim ulang OTP ke ${widget.email}")),
    );
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 64,
      height: 64,
      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: ThemeConfig.generalGray.withOpacity(0.3)),
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
    );

    return Scaffold(
      backgroundColor: ThemeConfig.whiteColor,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthOtpVerifySuccess) {
            // 1. SUKSES: Pergi ke Halaman Utama
            // TODO: Buat file 'home_page.dart'
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const JobListPage()),
              (route) => false, // Hapus semua halaman auth
            );
          } else if (state is AuthOtpVerifyFailure) {
            // 2. GAGAL: Ini 'warning' Anda
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error), // Pesan error dari API
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      // Padding atas/bawah 16
                      padding: const EdgeInsets.all(16),
                      onPressed: () => Navigator.pop(context),
                      color:
                          ThemeConfig.generalGray, // Sesuaikan warna jika perlu
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    "Masukkan kode OTP",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Silahkan masukkan kode OTP yang kamu terima melalui email",
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: ThemeConfig.generalGray,
                    ),
                  ),
                  const SizedBox(height: 16),

                  Center(
                    child: Pinput(
                      controller: _pinController,
                      length: 4, // API Anda mengirim 4 digit: "4994"
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: ThemeConfig.primaryDefault),
                        ),
                      ),
                      validator: (s) =>
                          (s?.length == 4) ? null : 'PIN tidak lengkap',
                    ),
                  ),
                  const SizedBox(height: 16),

                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _resendOtp,
                      child: Text(
                        "Kirim ulang",
                        style: ThemeConfig.buttonSecondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      // 1. Cek apakah state saat ini adalah state loading
                      //    (Gunakan state 'AuthOtpVerifying' yang kita buat)
                      final isLoading = state is AuthOtpVerifying;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          // 2. Nonaktifkan tombol jika 'isLoading' true
                          onPressed: isLoading ? null : _submitOtp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ThemeConfig.primaryDefault,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          // 3. Ubah 'child' tombol secara dinamis
                          child: isLoading
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 3,
                                )
                              : Text(
                                  "Daftar",
                                  style: ThemeConfig.buttonPrimary,
                                ),
                        ),
                      );
                    },
                  ),

                  const SizedBox(height: 16), // Jarak

                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        // TODO: Implementasi kirim OTP via WhatsApp
                        print("Kirim OTP WhatsApp");
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        // Style sama seperti tombol "Kirim via email"
                        side: BorderSide(color: ThemeConfig.primaryDefault),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Kirim OTP melalui Whatsapp",
                        // Gunakan style tombol sekunder
                        style: ThemeConfig.buttonSecondary,
                      ),
                    ),
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
