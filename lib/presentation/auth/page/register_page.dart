import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek
// TODO: Ganti import ini dengan path BLoC Anda yang sebenarnya
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/page/otp_verification_page.dart';
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
      context.read<AuthBloc>().add(
        AuthRegisterPressed(
          email: _emailController.text,
          name: _nameController.text,
          phone: _phoneController.text,
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.whiteColor,

      // --- BUNGKUS DENGAN BLOCLISTENER ---
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthRegisterSuccess) {
            // 1. REGISTRASI SUKSES -> TAMPILKAN MODAL
            _showOtpMethodSheet(context);
          } else if (state is AuthRegisterFailure) {
            // 2. REGISTRASI GAGAL -> TAMPILKAN ERROR
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          } else if (state is AuthOtpSentSuccess) {
            // (INI YANG PENTING UNTUK PINDAH HALAMAN)

            // 1. Tutup Bottom Sheet
            Navigator.pop(context);

            // 2. Pindah ke Halaman OTP
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    OtpVerificationPage(email: _emailController.text),
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
                          _isConfirmPasswordVisible =
                              !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Tombol Daftar
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      // Tampilkan loading jika state-nya RegisterLoading
                      final isLoading = state is AuthRegisterLoading;

                      return SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : _submitRegister,
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
                                  "Daftar",
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

  void _showOtpMethodSheet(BuildContext context) {
    FocusScope.of(context).unfocus(); // Tutup keyboard

    showModalBottomSheet(
      context: context,
      isDismissible: false,
      builder: (sheetContext) {
        // Berikan BLoC ke dalam bottom sheet
        return BlocProvider.value(
          value: BlocProvider.of<AuthBloc>(context),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kirim kode OTP",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  "Registrasi akun berhasil! Silakan pilih metode pengiriman kode OTP",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: ThemeConfig.generalGray,
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol WhatsApp (Non-aktif)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      print("Kirim OTP WhatsApp");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConfig.primaryDefault,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Kirim OTP melalui Whatsapp",
                      style: ThemeConfig.buttonPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Tombol Email (Aktif)
                SizedBox(
                  width: double.infinity,
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      final isLoading = state is AuthOtpSending;

                      return OutlinedButton(
                        onPressed: isLoading
                            ? null
                            : () {
                                // Panggil BLoC event
                                context.read<AuthBloc>().add(
                                  AuthSendOtpEmailPressed(
                                    email: _emailController.text,
                                  ),
                                );
                                // JANGAN tutup modal, biarkan BlocListener yang urus
                              },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: ThemeConfig.primaryDefault),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: isLoading
                            ? const CircularProgressIndicator()
                            : Text(
                                "Kirim OTP melalui email",
                                style: ThemeConfig.buttonSecondary,
                              ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
