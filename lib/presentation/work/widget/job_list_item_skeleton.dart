// lib/presentation/widgets/job_list_item_skeleton.dart

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class JobListItemSkeleton extends StatelessWidget {
  const JobListItemSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: const Color(0xFFE7ECFA), // <-- UBAH KE WARNA BIRU MUDA INI
      highlightColor: Colors.white,       // <-- UBAH HIGHLIGHT JADI PUTIH
      child: Container(
        padding: const EdgeInsets.all(16.0),
        margin: const EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white, // Ini akan ditimpa oleh baseColor shimmer
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[200]!), // Border tetap
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Baris 1: Judul
            Container(
              width: double.infinity,
              height: 18.0,
              color: Colors.white, // Biarkan putih, nanti shimmer akan berlaku
            ),
            const SizedBox(height: 12.0),
            Divider(color: Colors.grey[300]),
            const SizedBox(height: 12.0),

            // Baris 2: Logo, Nama Perusahaan, Lokasi
            Row(
              children: [
                // Logo placeholder (lingkaran)
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: const BoxDecoration(
                    color: Colors.white, // Biarkan putih
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama Perusahaan placeholder
                    Container(
                      width: 150.0,
                      height: 14.0,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 8.0),
                    // Lokasi placeholder
                    Container(
                      width: 100.0,
                      height: 12.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 16.0),

            // Baris 3: Diposting & Status (Open)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Diposting placeholder
                Container(
                  width: 120.0,
                  height: 12.0,
                  color: Colors.white,
                ),
                // Status placeholder
                Container(
                  width: 50.0,
                  height: 12.0,
                  color: Colors.white,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}