import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
// Pastikan nama proyek Anda benar
import 'package:mini_project1/config/theme_config.dart';
import 'package:mini_project1/gen/assets.gen.dart';
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/page/login_email_page.dart';
import 'package:mini_project1/presentation/auth/widget/auth_background_widget.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/presentation/work/page/work_page.dart';
import 'package:mini_project1/core/data/service/google_sign_in_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.primaryDefault,
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthLoginSuccess) {
            // JIKA LOGIN SUKSES (DARI GOOGLE ATAU DARI EMAIL)
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                // Pindah ke halaman daftar pekerjaan
                builder: (context) => const JobListPage(),
              ),
              (route) => false, // Hapus semua halaman auth
            );
          } else if (state is AuthLoginFailure) {
            // JIKA LOGIN GAGAL
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Stack(
          // <-- Stack Anda sekarang ada di dalam 'child'
          children: [
            // 2. BACKGROUND YANG SAMA
            const AuthBackgroundWidget(),

            // 3. KONTEN BARU
            const _BuildContent(),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// WIDGET KONTEN (Kartu Putih)
// -----------------------------------------------------------------
class _BuildContent extends StatelessWidget {
  const _BuildContent();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 324,
        width: 375,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24),
            topRight: Radius.circular(24),
          ),
        ),

        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Teks Judul & Subjudul (BARU)
              Text(
                "Selamat Datang",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                "Silahkan metode berikut untuk masuk atau daftar", // Teks baru
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeConfig.generalGray,
                ),
              ),
              const SizedBox(height: 16),

              // 2. Tombol Google (BARU)
              _buildLoginButton(
                context,
                iconAsset: Assets.icons.icGoogle,
                text: "Lanjutkan dengan Google",
                onPressed: () {
                  // Panggil method helper kita
                  _handleGoogleSignIn(context);
                },
              ),
              const SizedBox(height: 16),

              // 3. Tombol Email (BARU)
              _buildLoginButton(
                context,
                // Pastikan nama aset ini ada
                iconAsset: Assets.icons.icMail,
                text: "Lanjutkan dengan Email",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginEmailPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 4. Teks Footer (Sama)
              Center(child: _buildFooterText(context)),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    print("DEBUG: _handleGoogleSignIn() dipanggil!");

    try {
      print("DEBUG: Memanggil GoogleSignInService.login() ...");
      final GoogleSignInAccount? account = await GoogleSignInService.login();

      print("DEBUG: GoogleSignInService.login() selesai.");
      print("DEBUG: Account: $account");

      if (account == null) {
        print("DEBUG: USER MEMBATALKAN LOGIN.");
        return;
      }

      print("DEBUG: Mendapatkan authentication...");
      final GoogleSignInAuthentication auth = await account.authentication;

      print("DEBUG: auth.accessToken = ${auth.accessToken}");
      print("DEBUG: auth.idToken = ${auth.idToken}");

      final String? idToken = auth.idToken;

      if (idToken == null) {
        print("ERROR: idToken NULL !!!!!");
        throw Exception('Gagal mendapatkan idToken dari Google.');
      }

      print("DEBUG: idToken berhasil didapat!");
      print("Google ID Token: $idToken");

      // =============== SPLIT TOKEN ===============
      final tokenParts = idToken.split('.');
      print("TOKEN LENGTH: ${tokenParts.length}");

      if (tokenParts.length == 3) {
        print("PART 1 (HEADER): ${tokenParts[0]}");
        print("PART 2 (PAYLOAD): ${tokenParts[1]}");
        print("PART 3 (SIGNATURE): ${tokenParts[2]}");
      } else {
        print("WARNING: TOKEN TIDAK VALID (bukan 3 part)");
      }
      // ===========================================

      print("============== Print Data User ==============");
      print("USER NAME: ${account.displayName}");
      print("USER EMAIL: ${account.email}");

      print("DEBUG: Mengirim token ke BLoC...");
      if (context.mounted) {
        context.read<AuthBloc>().add(AuthGoogleSignInPressed(idToken));
      }
    } catch (e, stack) {
      print("ERROR TERJADI SAAT LOGIN GOOGLE: $e");
      print("STACKTRACE: $stack");

      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Login Google Gagal: $e')));
      }
    }
  }

  // --- WIDGET HELPER UNTUK TOMBOL ---
  // Ini adalah salinan dari _buildRoleButton, kita bisa pakai ulang
  Widget _buildLoginButton(
    BuildContext context, {
    required AssetGenImage iconAsset, // 1. Sekarang menerima AssetGenImage
    required String text,
    required VoidCallback onPressed,
  }) {
    // 2. Terapkan ukuran tetap dari Figma (width: 343, height: 48)
    return SizedBox(
      width: 343,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          // 3. Terapkan padding kiri/kanan
          padding: const EdgeInsets.symmetric(horizontal: 16),

          // 4. Terapkan border-radius dan outline
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // border-radius: 12px
          ),
          side: const BorderSide(
            color: Color(0xffE7ECFA), // outline warna #E7ECFA
            width: 1, // border-width: 1px
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Rata tengah
          children: [
            // 5. Ikon dari Aset
            iconAsset.image(
              width: 24, // Tentukan ukuran ikon
              height: 24,
            ),

            // 6. Terapkan 'gap: 12px'
            const SizedBox(width: 12),

            // 7. Teks
            Text(
              text,
              // Gunakan style tombol sekunder dari tema
              style: ThemeConfig.buttonLoginOption.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER UNTUK FOOTER ---
  // Ini adalah salinan dari halaman sebelumnya
  Widget _buildFooterText(BuildContext context) {
    return Text.rich(
      TextSpan(
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: ThemeConfig.generalGray),
        children: [
          const TextSpan(text: "Dengan mendaftar, Saya menyetujui\n"),
          TextSpan(
            text: "Syarat dan Ketentuan",
            style: const TextStyle(
              color: ThemeConfig.primaryDefault,
              fontWeight: ThemeConfig.semibold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print("Buka Syarat dan Ketentuan");
              },
          ),
          const TextSpan(text: " yang berlaku dan "),
          TextSpan(
            text: "Kebijakan Privasi",
            style: const TextStyle(
              color: ThemeConfig.primaryDefault,
              fontWeight: ThemeConfig.semibold,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                print("Buka Kebijakan Privasi");
              },
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
