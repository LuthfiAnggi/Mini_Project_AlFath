import 'package:flutter/material.dart';

class ErorrServer extends StatelessWidget {
  const ErorrServer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // Kita beri padding agar tidak terlalu mepet ke tepi
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Gambar Ilustrasi
              Image.asset(
                'assets/img_erorr_504.png', // Ganti dengan path aset Anda
                width: 240,
                height: 154, // Sesuaikan ukurannya
              ),

              // 2. Jarak
              SizedBox(height: 16.0), 

              // 3. Teks Error (Baris 1)
              Text(
                'Terdapat kesalahan pada server.\nSilahkan muat ulang!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400, // Sedikit tebal
                  color: Colors.grey, // Warna abu-abu tua
                ),
              ),

              // 5. Jarak
              SizedBox(height: 16.0),

              // 6. Tombol "Muat Ulang"
              ElevatedButton.icon(
                onPressed: () {
                  // Aksi saat tombol ditekan (bisa dikosongi dulu)
                },
                icon: Icon(
                  Icons.refresh,
                  weight: 24,
                  color: Colors.white, // Warna ikon
                ),
                label: Text(
                  'Muat Ulang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white, // Warna teks
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  // Ambil warna biru dari desain
                  backgroundColor: Color(0xFF34A8DB), 
                  
                  // Atur bentuknya
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  
                  // Atur padding (ukuran tombol)
                  padding: EdgeInsets.symmetric(
                    horizontal: 32.0, 
                    vertical: 16.0,
                  ),
                  
                  // Hilangkan bayangan jika perlu
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