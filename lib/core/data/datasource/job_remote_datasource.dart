// lib/data/services/api_service.dart

import 'package:http/http.dart' as http;
// Import model Anda, pastikan nama filenya benar
import '../model/job_model.dart';
import '../model/job_detail_model.dart';

class ApiService {
  final String baseUrl = "https://kkloker.partnercoding.com";

  final String _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwczpcL1wva2tsb2tlci5wYXJ0bmVyY29kaW5nLmNvbVwvYXBpXC9qb2JzZWVrZXJcL3Bla2VyamFhblwvZ2V0QWN0aXZlUGVrZWphYW4iLCJpYXQiOjE3NjE1MzQ4MTMsImV4cCI6MTc2MjMyMDUyNCwibmJmIjoxNzYyMjM0MTI0LCJqdGkiOiJNMXUwZmM5NGNRWFRuTmdyIiwic3ViIjoyLCJwcnYiOiIyM2JkNWM4OTQ5ZjYwMGFkYjM5ZTcwMWM0MDA4NzJkYjdhNTk3NmY3In0.KhCPHqQNsPsGGLdki5liLY5-EXnYc3UvENVKGMEWVXs";

  // Fungsi untuk mengambil DAFTAR LOWONGAN
  Future<JobModel> getJobs({
    Map<String, String>? filters,
    String? searchQuery, 
    }) async {
    

    Map<String, String> queryParams = {
      'jenis': 'Nasional',
    };


    if (filters != null) {
      // Tambah filter 'tipe' jika bukan 'Semua'
      if (filters.containsKey('tipe') && filters['tipe'] != 'Semua') {
        // UBAH 'tipe' MENJADI 'tipe[]'
        queryParams['tipe[]'] = filters['tipe']!; // <-- INI BARIS PERBAIKANNYA
      }
      
      // Tambah filter 'minimalGaji'
      if (filters.containsKey('minimalGaji')) {
        queryParams['minimalGaji'] = filters['minimalGaji']!;
      }
      
      // (Tambahkan 'maksimalGaji' di sini jika API Anda mendukungnya)
      if (filters.containsKey('maksimalGaji')) {
        queryParams['maksimalGaji'] = filters['maksimalGaji']!;
      }
      
    }

    if (searchQuery != null && searchQuery.isNotEmpty) {
      queryParams['search'] = searchQuery; 
    }
    

    final url = Uri.parse('$baseUrl/api/jobseeker/pekerjaan/getActivePekejaan')
        .replace(queryParameters: queryParams); // <-- Ini cara aman

    print("API memanggil URL: $url"); 

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
