import 'dart:convert'; // Diperlukan untuk jsonEncode dan jsonDecode
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  // TODO: Ganti dengan URL API Anda yang sebenarnya
  // Ambil dari Postman Anda
  final String _baseUrl = "https://kkloker.partnercoding.com";

  /// Mengecek apakah email sudah terdaftar di server.
  ///
  /// Mengirim `POST` request ke `url/api/checkEmail`.
  /// Mengembalikan `true` jika terdaftar, `false` jika tidak.
  Future<bool> checkEmail(String email) async {
    // 1. Siapkan URL lengkap
    // Ganti 'api/checkEmail' jika endpoint Anda berbeda
    final url = Uri.parse('$_baseUrl/api/checkEmail');

    // 2. Siapkan headers untuk memberi tahu server bahwa kita mengirim JSON
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // 3. Siapkan body (data) yang akan dikirim, ubah ke format JSON
    final body = jsonEncode({'email': email});

    try {
      // 4. Kirim POST request menggunakan http
      final response = await http.post(url, headers: headers, body: body);

      // 5. Cek jika request sukses (kode 200-299)
      if (response.statusCode == 200) {
        // 6. Ubah response body (String) menjadi Map (JSON)
        final data = jsonDecode(response.body);

        // 2. Cek 'meta.status_code' dari API Anda
        if (data['meta'] != null && data['meta']['status_code'] == 200) {
          // 3. Ambil data dari path yang benar: data -> is_registered
          // Pastikan key 'data' dan 'is_registered' ada
          if (data['data'] != null && data['data']['is_registered'] != null) {
            final bool isRegistered = data['data']['is_registered'];
            return isRegistered;
          } else {
            // Jika key 'data' atau 'is_registered' tidak ada
            throw Exception('Format data respons tidak dikenal.');
          }
        } else {
          // Jika API mengembalikan status error (misal 404 tapi di dalam meta)
          final String message = data['meta']?['message'] ?? 'API Gagal';
          throw Exception('API Gagal: $message');
        }
      } else {
        // Jika server error (404, 500, dll)
        throw Exception('Gagal menghubungi server: ${response.statusCode}');
      }
    } catch (e) {
      // Jika ada error jaringan (misal, tidak ada internet atau URL salah)
      throw Exception('Terjadi kesalahan jaringan: $e');
    }
  }

  Future<String> login(String email, String password) async {
    // TODO: Ganti 'api/login' dengan endpoint login Anda dari Postman
    final url = Uri.parse('$_baseUrl/api/login');

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    // Siapkan body untuk dikirim
    final body = jsonEncode({'email': email, 'password': password});

    try {
      // Kirim POST request
      final response = await http.post(url, headers: headers, body: body);

      final data = jsonDecode(response.body);

      // Cek jika request sukses (biasanya 200)
      if (response.statusCode == 200) {
        // TODO: Cek JSON Anda di Postman untuk path token yang benar
        // Asumsi API mengembalikan: {"data": {"token": "12345"}}
        // Sesuaikan path 'data' dan 'token'
        if (data['data'] != null && data['data']['token'] != null) {
          return data['data']['token'] as String;
        } else {
          throw Exception('Format respons token tidak dikenal.');
        }
      } else {
        // Jika login gagal (misal, 401 atau 404)
        // Asumsi API memberi pesan error: {"meta": {"message": "Password salah"}}
        final String message =
            data['meta']?['message'] ?? 'Email atau password salah';
        throw Exception(message);
      }
    } catch (e) {
      // Error jaringan atau error parsing
      throw Exception('Gagal memproses data: $e');
    }
  }
}
