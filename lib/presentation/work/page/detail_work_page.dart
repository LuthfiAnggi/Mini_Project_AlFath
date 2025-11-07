import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/job_detail/job_detail_bloc.dart';
import '../bloc/job_detail/job_detail_state.dart';
// import '../../data/models/job_detail_model.dart';
import '../bloc/job_detail/job_detail_event.dart';

class JobDetailPage extends StatefulWidget {
  // 1. Tambahkan properti untuk menerima ID
  final String jobId;

  // 2. Perbarui constructor
  const JobDetailPage({
    super.key,
    required this.jobId, // Buat ini wajib diisi
  });

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  @override
  void initState() {
    super.initState();
    // PASTIKAN BARIS INI ADA DAN TIDAK DI-COMMENT
    print(
      "--- JobDetailPage: Mengirim event FetchJobDetail ---",
    ); // Log tambahan
    context.read<JobDetailBloc>().add(FetchJobDetail(widget.jobId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // ... (AppBar Anda) ...
        title: Text(
          'Detail Lowongan',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
        ),
        leading: IconButton(
          icon: Image.asset('assets/ic_arrow-left.png', width: 24, height: 24),
          onPressed: () => Navigator.of(context).pop(),
        ),
        titleSpacing: 3.0,
      ),

      // (Nanti kita akan ubah body ini untuk memanggil BLoC detail)
      body: BlocBuilder<JobDetailBloc, JobDetailState>(
        builder: (context, state) {
          // iki ketika loading nanti diganti ========
          if (state is JobDetailLoading || state is JobDetailInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          // iki ketika erorr pak ===============
          if (state is JobDetailError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Gagal memuat detail: ${state.message}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (state is JobDetailLoaded) {
            // Ambil data dari state
            final job = state.jobDetail.data.pekerjaan;
            final company = state.jobDetail.data.perusahaan;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // --- HEADER (Logo, Judul, Perusahaan) ---
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(company.logo),
                          radius: 30,
                          backgroundColor: Colors.grey[200],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          // Bungkus dengan Expanded agar teks tidak overflow
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                // Gunakan RegExp untuk membersihkan judul
                                job.nama.replaceAll(RegExp(r' \d+$'), ''),
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                company.nama,
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // --- TANGGAL & STATUS ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Diposting ${job.createdAt}',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                        Text(
                          job.tipe, // Data 'Open' tidak ada, kita ganti Tipe
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 16),

                    // --- DESKRIPSI ---
                    const Text(
                      'Deskripsi Pekerjaan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      job.deskripsi,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[800],
                        height: 1.5, // Jarak antar baris
                      ),
                    ),

                    // Anda bisa tambahkan bagian 'Skill' di sini
                    const SizedBox(height: 24),
                    const Text(
                      'Keahlian',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    // Tampilkan skill menggunakan Wrap
                    Wrap(
                      spacing: 8.0, // Jarak horizontal antar chip
                      runSpacing: 4.0, // Jarak vertikal antar baris
                      children: job.skill
                          .map(
                            (s) => Chip(
                              label: Text(s.name),
                              backgroundColor: Colors.blue[50],
                            ),
                          )
                          .toList(),
                    ),

                    // Padding tambahan di bawah
                    const SizedBox(height: 80),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink(); // Fallback
        },
      ),

      // 3. Tombol "Apply Sekarang"
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF34A8DB),
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          child: const Text(
            'Apply Sekarang',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
