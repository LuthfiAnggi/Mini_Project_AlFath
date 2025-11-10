import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mini_project1/config/theme_config.dart'; // Ganti nama proyek
import 'package:mini_project1/gen/assets.gen.dart';
import 'package:mini_project1/presentation/auth/bloc/auth_bloc.dart';
import 'package:mini_project1/presentation/auth/page/login_Page.dart';
import 'package:mini_project1/presentation/auth/widget/auth_background_widget.dart';
import 'package:mini_project1/presentation/auth/widget/auth_footer_widget.dart';

class AuthOptionsPage extends StatelessWidget {
  const AuthOptionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: ThemeConfig.primaryDefault,

      body: Stack(
        children: [
          // BAGIAN 1: Background Gambar Penuh dengan Overlay
          AuthBackgroundWidget(),

          // BAGIAN 2: Konten Box Putih
          _BuildContent(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// WIDGET KONTEN
// -----------------------------------------------------------------
class _BuildContent extends StatelessWidget {
  const _BuildContent();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // Perkiraan tinggi, sesuaikan jika perlu
        height: 355,
        width: 375,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 64),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        // Kita bungkus dengan SingleChildScrollView agar aman dari overflow
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 1. Teks Judul & Subjudul
              Text(
                "Selamat Datang",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 4),
              Text(
                "Silakan pilih jenis akun untuk melanjutkan",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: ThemeConfig.generalGray,
                ),
              ),
              const SizedBox(height: 16),

              // 2. Tombol Pengguna
              _buildRoleButton(
                context,
                iconAsset: Assets.icons.icUsers,
                text: "Login Sebagai Pengguna",
                onPressed: () {
                  // Kita mengirim STRING "jobseeker" (bukan hash, bukan int)
                  context.read<AuthBloc>().add(
                    const AuthRoleSelected("jobseeker"),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 3. Pemisah "atau"
              _buildDivider(context),
              const SizedBox(height: 16),

              // 4. Tombol Perusahaan
              _buildRoleButton(
                context,
                iconAsset: Assets.icons.icBuilding,
                text: "Login Sebagai Perusahaan",
                onPressed: () {
                  // Kita mengirim STRING "jobseeker" (bukan hash, bukan int)
                  context.read<AuthBloc>().add(
                    const AuthRoleSelected("company"),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 5. Teks Footer
              const Center(child: AuthFooterWidget()),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER UNTUK TOMBOL (VERSI BARU SESUAI FIGMA) ---
  Widget _buildRoleButton(
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
              color: ThemeConfig.primaryDefault,
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

  // --- WIDGET HELPER UNTUK PEMISAH "ATAU" ---
  Widget _buildDivider(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(color: ThemeConfig.generalGray.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "atau",
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: ThemeConfig.generalGray),
          ),
        ),
        Expanded(
          child: Divider(color: ThemeConfig.generalGray.withOpacity(0.3)),
        ),
      ],
    );
  }
}
