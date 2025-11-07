import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// Pastikan nama proyek Anda benar
import 'package:mini_project1/config/theme_config.dart';
import 'package:mini_project1/gen/assets.gen.dart';
import 'package:mini_project1/presentation/auth/page/login_email_page.dart';
import 'package:mini_project1/presentation/auth/widget/auth_background_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeConfig.primaryDefault,
      body: Stack(
        children: [
          // 2. BACKGROUND YANG SAMA
          const AuthBackgroundWidget(),

          // 3. KONTEN BARU
          const _BuildContent(),
        ],
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
                // Pastikan nama aset ini ada
                iconAsset: Assets.icons.icGoogle,
                text: "Lanjutkan dengan Google",
                onPressed: () {
                  // Aksi login Google
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
