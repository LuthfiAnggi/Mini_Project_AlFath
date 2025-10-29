import 'package:flutter/material.dart';
import 'package:mini_project1/presentation/pages/job_detail_page.dart';
import '../../data/models/job_model.dart';

class JobListItemCard extends StatelessWidget {
  // Ganti dengan satu properti ini:
  final Datum jobData;

  // 4. Perbarui constructor
  const JobListItemCard({Key? key, required this.jobData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => JobDetailPage(jobId: jobData.pekerjaan.key),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        margin: EdgeInsets.only(bottom: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Column(
          
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12.0),
            // --- BARIS 1 ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  jobData.pekerjaan.nama.replaceAll(RegExp(r' \d+$'), ''),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Text(
                  // Ambil nama Enum dari Tipe (ini masih Enum, jadi aman)
                  tipeValues.reverse[jobData.pekerjaan.tipe]!,
                  style: TextStyle(color: Colors.blue),
                ),
              ],
            ),
            SizedBox(height: 12.0),
            Divider(color: Color(0xFFE7ECFA)),
            SizedBox(height: 12.0),

            // --- BARIS 2 ---
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white,// Warna background saat loading atau error
                  backgroundImage: NetworkImage(
                    jobData.perusahaan.logo,
                  ), 
                ),
                SizedBox(width: 12.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobData.perusahaan.nama,
                      style: TextStyle(
                        color: Color(0xff0F172A),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,

                      ), // <-- LANGSUNG PAKAI STRING
                    ),
                    Text(
                      jobData.pekerjaan.lokasi, // <-- LANGSUNG PAKAI STRING
                      style: TextStyle(color: Color(0xFF6974AA),
                      fontSize: 12,
                      fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12.0),

            // --- BARIS 3 ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Diposting ${jobData.pekerjaan.createdAt}', // <-- LANGSUNG PAKAI STRING
                  style: TextStyle(color: Colors.grey),
                ),
                Text('Open', style: TextStyle(color: Colors.green)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
