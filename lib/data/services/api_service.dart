// lib/data/services/api_service.dart

import 'package:http/http.dart' as http;
// Import model Anda, pastikan nama filenya benar
import '../models/job_model.dart';
import '../models/job_detail_model.dart';

class ApiService {
  final String baseUrl = "https://kkloker.partnercoding.com";

  final String _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wva2tsb2tlci5wYXJ0bmVyY29kaW5nLmNvbVwvYXBpXC9qb2JzZWVrZXJcL3Bla2VyamFhblwvZ2V0QWN0aXZlUGVrZWphYW4iLCJpYXQiOjE3NjE1MzQ4MTMsImV4cCI6MTc2MTg5MzE0NywibmJmIjoxNzYxODA2NzQ3LCJqdGkiOiIxNUhKb3dKSDM5cTIxU3dBIiwic3ViIjoyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.A2ec0Huu21FbINREX5ITOh8Cmg1UnxrOK8uh2PKZN0k";

  // Fungsi untuk mengambil DAFTAR LOWONGAN
  Future<JobModel> getJobs() async {
    final url = Uri.parse('$baseUrl/api/jobseeker/pekerjaan/getActivePekejaan');

    try {
     final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // 1. Ambil seluruh body response (String)
        final String responseBody = response.body;

        // 2. Langsung panggil factory 'fromRawJson' dari model Quicktype
        // Ini akan mengurai SEMUA-nya (meta, data, dll) secara otomatis
        return JobModel.fromRawJson(responseBody);
      } else {
        // Jika status code bukan 200
        throw Exception(
          'Gagal memuat lowongan (Status code: ${response.statusCode})',
        );
      }
    } catch (e) {
      // Jika terjadi error lain (misal tidak ada internet)
      throw Exception('Terjadi error: $e');
    }
  }

  Future<JobDetailModel> getJobDetail(String id) async {
    // API endpoint-nya menggunakan ID
    final url =
        Uri.parse('$baseUrl/api/jobseeker/pekerjaan/getActivePekejaan/$id');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $_token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        // Gunakan model baru kita
        return JobDetailModel.fromRawJson(response.body);
      } else {
        throw Exception('Gagal memuat detail lowongan (Status: ${response.statusCode}) - Body: ${response.body}');
      }
    } catch (e) {
      throw Exception('Terjadi error: $e');
    }
  }
}
