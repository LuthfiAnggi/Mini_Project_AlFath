import 'package:flutter/material.dart';
// 1. IMPORT STYLE, ASET, DAN HALAMAN 2
import 'package:mini_project1/config/theme_config.dart'; // Ganti 'mini_project1' dengan nama proyek Anda
import 'package:mini_project1/gen/assets.gen.dart';
import 'package:mini_project1/gen/fonts.gen.dart';
import 'package:mini_project1/presentation/onboarding/page/onboarding2_page.dart'; // Ganti 'mini_project1' dengan nama proyek Anda

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

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
            // Kirim ilustrasi Halaman 1
            illustrationAsset: Assets.images.imgIllustration1,
          ),

          // BAGIAN 2: Panggil widget baru _BuildContent
          // (Tidak perlu screenHeight lagi)
          const _BuildContent(),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------
// WIDGET BARU UNTUK LATAR BELAKANG
// (Ini adalah KODE YANG SAMA PERSIS dari OnboardingPage2)
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
          // Ambil gambar background dari aset
          image: Assets.images.imgBgOnboarding.provider(),
          fit: BoxFit.cover,
        ),
      ),
      child: SingleChildScrollView(
        // Ini sudah benar
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Kita samakan ukurannya dengan Halaman 2 agar konsisten
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
// WIDGET KONTEN (PERBAIKAN POSISI TOMBOL)
// -----------------------------------------------------------------
class _BuildContent extends StatelessWidget {
  const _BuildContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        // Menggunakan tinggi dan padding yang sudah benar
        height: 329,
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          // Menggunakan radius yang sudah benar
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        
        // --- PERBAIKAN DI SINI ---
        // 1. Ganti 'spaceBetween' menjadi 'start'
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // <-- DIUBAH
          children: [
            // Konten Teks
            Column(
              children: [
                Text(
                  "Selamat Datang di Kejarkarirmu",
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  "Kejarkarirmu adalah platform untuk mengembangkan karir melalui kursus dan informasi lowongan kerja",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ],
            ),

            // 2. Tambahkan SizedBox(height: 24)
            const SizedBox(height: 24), // <-- DITAMBAHKAN

            // Tombol Lanjut (Satu tombol saja)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aksi untuk pindah ke halaman onboarding 2
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OnboardingPage2(),
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
                // --- PERBAIKAN STYLE TOMBOL ---
                child: Text( // Hapus 'const' di sini
                  "Lanjut",
                  // Gunakan style dari ThemeConfig
                  style: TextStyle(
                          fontFamily: FontFamily.inter,
                          fontSize: 14,
                          fontWeight: ThemeConfig.medium,
                          color: Colors.white,
                        ), // <-- DIUBAH
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

