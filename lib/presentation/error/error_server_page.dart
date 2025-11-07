import 'package:flutter/material.dart';

class ErorrServer extends StatelessWidget {
  // 1. TAMBAHKAN PARAMETER INI UNTUK MENERIMA FUNGSI onRetry
  final VoidCallback onRetry;

  // 2. PERBARUI CONSTRUCTOR UNTUK MEMBUATNYA WAJIB
  const ErorrServer({
    super.key,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Gambar Ilustrasi
              Image.asset(
                'assets/img_erorr_504.png', // Pastikan path ini benar
                width: 240,
                height: 154,
              ),

              // 2. Jarak
              const SizedBox(height: 16.0),

              // 3. Teks Error
              const Text(
                'Terdapat kesalahan pada server.\nSilahkan muat ulang!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey,
                ),
              ),

              // 4. Jarak
              const SizedBox(height: 16.0),

              // 5. Tombol "Muat Ulang"
              ElevatedButton.icon(
                // 3. GUNAKAN 'onRetry' DARI CONSTRUCTOR DI SINI
                onPressed: onRetry,
                icon: const Icon(
                  Icons.refresh,
                  size: 24, // <-- Saya perbaiki 'weight' menjadi 'size'
                  color: Colors.white,
                ),
                label: const Text(
                  'Muat Ulang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF34A8DB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32.0,
                    vertical: 16.0,
                  ),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}