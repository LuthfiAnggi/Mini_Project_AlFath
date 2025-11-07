import 'package:flutter/material.dart';
// 1. IMPORT STYLE DAN ASET ANDA
import 'package:mini_project1/config/theme_config.dart'; // Ganti 'mini_project1' dengan nama proyek Anda
import 'package:mini_project1/gen/assets.gen.dart';
import 'package:mini_project1/gen/fonts.gen.dart';
import 'package:mini_project1/presentation/onboarding/page/onboarding3_page.dart'; // Ganti 'mini_project1' dengan nama proyek Anda

class OnboardingPage2 extends StatelessWidget {
  const OnboardingPage2({super.key});

  @override
  Widget build(BuildContext context) {
    // Kita gunakan MediaQuery untuk mendapatkan tinggi layar
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // BAGIAN 1: Panggil widget baru _BuildBackground
          _BuildBackground(
            screenHeight: screenHeight,

            // --- PERBAIKAN BUG ---
            // Ini halaman 2, jadi kita panggil ilustrasi 2
            illustrationAsset: Assets.images.imgIllustration2,
          ),

          // BAGIAN 2: Panggil widget baru _BuildContent
          // --- PERBAIKAN CLEANUP ---
          // Kita hapus parameter screenHeight karena sudah tidak dipakai
          const _BuildContent(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// WIDGET BARU UNTUK LATAR BELAKANG
// (Kode Anda di sini sudah benar dengan SingleChildScrollView)
// -----------------------------------------------------------------
class _BuildBackground extends StatelessWidget {
  const _BuildBackground({
    required this.screenHeight,
    required this.illustrationAsset,
  });

  final double screenHeight;
  final AssetGenImage illustrationAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: screenHeight * 0.6, // Ambil 60% layar
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Assets.images.imgBgOnboarding.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        // Ini sudah benar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 70),
            Assets.images.imgLogoLight.image(height: 56, width: 160),
            const SizedBox(height: 40),
            illustrationAsset.image(
              // Menggunakan parameter
              width: 451,
              height: 304,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------
// WIDGET KONTEN (INI YANG DIPERBAIKI DARI ERROR ANDA)
// -----------------------------------------------------------------
class _BuildContent extends StatelessWidget {
  // --- PERBAIKAN CLEANUP ---
  // Hapus screenHeight, sudah tidak dipakai lagi
  const _BuildContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 329,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),

        // --- PERBAIKAN RENDERFLEX OVERFLOW ---
        // 1. Bungkus Column dengan SingleChildScrollView
        child: SingleChildScrollView(
          child: Column(
            // 2. GANTI 'spaceBetween' menjadi 'start'
            //    'spaceBetween' tidak berfungsi di dalam SingleChildScrollView
            //    Biarkan SizedBox(height: 24) yang memberi jarak.
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Konten Teks
              Column(
                children: [
                  Text(
                    "Pelajari Skill yang Dibutuhkan Industri", // Teks baru
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Akses berbagai materi yang relevan untuk meningkatkan keterampilan Anda sesuai kebutuhan pasar kerja.", // Teks baru
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: 24), // Ini sekarang jadi jaraknya
              // Tombol Lanjut
              Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Aksi untuk ke halaman selanjutnya
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingPage3(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: ThemeConfig.primaryDefault,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        "Lanjut",
                        style: TextStyle(
                          fontFamily: FontFamily.inter,
                          fontSize: 14,
                          fontWeight: ThemeConfig.medium,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Aksi kembali
                    },
                    child: Text(
                      "Kembali",
                      style: TextStyle(
                        fontFamily: FontFamily.inter,
                        fontSize: 14,
                        fontWeight: ThemeConfig.medium,
                        color: ThemeConfig.primaryDefault,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
