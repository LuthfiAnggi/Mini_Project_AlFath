// lib/presentation/pages/error_connection.dart (atau apapun nama filenya)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // <-- 1. IMPORT BLOC
import 'package:mini_project1/bloc/job_list/job_list_event.dart';
import '../../bloc/job_list/job_list_bloc.dart'; // <-- 2. IMPORT BLOC ANDA

class ErorrConnection extends StatelessWidget {
  const ErorrConnection({super.key});

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/img_erorr_connection.png", // Pastikan path aset ini benar
              width: 220,
              height: 220,
            ),
            const SizedBox(height: 24.0),
            const Text(
              'Tidak Terhubung ke Internet.',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 24.0),

            // --- 3. TAMBAHKAN TOMBOL INI ---
            ElevatedButton.icon(
              icon: const Icon(Icons.refresh),
              label: const Text('Coba Lagi'),
              onPressed: () {
                // 4. Panggil BLoC untuk mencoba mengambil data lagi
                context.read<JobListBloc>().add(FetchJobList());
              },
            )
            // ---------------------------
          ],
        ),
      ),
    );
  }
}