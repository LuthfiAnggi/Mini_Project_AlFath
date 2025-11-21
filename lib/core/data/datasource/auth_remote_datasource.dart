import 'dart:convert'; // Diperlukan untuk jsonEncode dan jsonDecode
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart'; // Diperlukan untuk sha256
import 'package:mini_project1/core/data/service/session_service.dart';

class AuthRemoteDatasource {
  final String _baseUrl = "https://kkloker.partnercoding.com";
  final SessionService _sessionService;

  AuthRemoteDatasource(this._sessionService);

  /// Mengirim `POST` request ke `url/api/checkEmail`.
  Future<bool> checkEmail(String email) async {
    // 1. Siapkan URL lengkap
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

  // METHOD UNTUK REGISTRASI
  // Mengembalikan 'token' (JWT) berdasarkan JSON Anda
  Future<String> register({
    required String email,
    required String name,
    required String phone,
    required String password,
    required String role,
  }) async {
    final url = Uri.parse('$_baseUrl/api/register');

    // buat hash
    var bytes = utf8.encode(role); // 'role' (misal "jobseeker")
    var digest = sha256.convert(bytes);
    String roleHash = digest.toString();

    // --- 2. SIAPKAN HEADERS BARU ---
    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest', // <-- WAJIB ADA
      'X-Role-Hash': roleHash, // <-- WAJIB ADA (menggunakan hash di atas)
    };
    final body = jsonEncode({
      'email': email,
      'name': name,
      'phoneNumber': phone, // <-- SESUAIKAN KEY INI DENGAN API ANDA
      'password': password,
      'password_confirmation': password,
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      // Cek jika API sukses
      if (response.statusCode == 200 || response.statusCode == 201) {
        // AMBIL TOKEN DARI JSON (sesuai file Postman Anda)
        if (data['data'] != null && data['data']['token'] != null) {
          return data['data']['token'] as String;
        } else {
          throw Exception('Format respons token tidak dikenal.');
        }
      } else {
        // Jika registrasi GAGAL
        final String message = data['meta']?['message'] ?? 'Registrasi gagal';
        throw Exception(message);
      }
    } catch (e) {
      throw Exception('Gagal memproses data: $e');
    }
  }

  // METHOD UNTUK verif OTP
  Future<void> sendOtpEmail(String email) async {
    final url = Uri.parse('$_baseUrl/api/sendOTPEmail');
    // --- 1. AMBIL TOKEN (PENTING) ---
    final token = _sessionService.getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan di sesi lokal.');
    }

    // --- 2. TAMBAHKAN TOKEN KE HEADERS (PENTING) ---
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token', // <-- INI YANG MUNGKIN HILANG
    };

    final body = jsonEncode({'email': email});

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      if (data['meta']?['status_code'] != 200) {
        final String message = data['meta']?['message'] ?? 'Gagal mengirim OTP';
        throw Exception(message);
      }
      // Jika sukses (200), tidak perlu mengembalikan apa-apa
    } catch (e) {
      throw Exception('Gagal memproses data: $e');
    }
  }

  Future<void> verifyEmailOtp(String otp) async {
    // TODO: Ganti 'api/verifyEmailOTP' dengan endpoint Anda yang sebenarnya
    final url = Uri.parse('$_baseUrl/api/verificationEmail');

    // Ambil token login dari Hive
    final token = _sessionService.getToken();
    if (token == null) {
      throw Exception('Token tidak ditemukan di sesi lokal.');
    }

    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token', // Kirim token login
    };

    final body = jsonEncode({
      'verificationToken': otp, // <-- KEY YANG BENAR
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      final data = jsonDecode(response.body);

      // 5. PENANGANAN ERROR YANG LEBIH BAIK
      if (data['meta']?['status_code'] != 200) {
        // Tampilkan pesan error ASLI dari server
        final String message =
            data['meta']?['message'] ?? 'Verifikasi OTP gagal';
        throw Exception(message);
      }
      // Jika sukses (200), tidak perlu mengembalikan apa-apa
    } catch (e) {
      throw Exception('Gagal memproses data: $e');
    }
  }

  // METHOD BARU UNTUK LOGIN GOOGLE

  Future<String> loginWithGoogle({
    required String googleTokenId,
    required String role, // "jobseeker" atau "company"
  }) async {
    final url = Uri.parse('$_baseUrl/api/google/verifyTokenId');

    // GUNAKAN CARA YANG SAMA DENGAN REGISTER
    var bytes = utf8.encode(role); // 'jobseeker' atau 'company'
    var digest = sha256.convert(bytes);
    String roleHash = digest.toString();

    final headers = {
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'X-Requested-With': 'XMLHttpRequest',
      'X-Role-Hash': roleHash, // Hash yang konsisten dengan register
    };

    final body = jsonEncode({'tokenId': googleTokenId});

    try {
      final response = await http.post(url, headers: headers, body: body);

      // DEBUG: Print untuk troubleshooting
      print('Role: $role');
      print('Role Hash: $roleHash');
      print('Response Status: ${response.statusCode}');
      print('Response Body: ${response.body}');

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (data['data'] != null && data['data']['token'] != null) {
          return data['data']['token'] as String;
        } else if (data['token'] != null) {
          return data['token'] as String;
        } else {
          throw Exception('Format token tidak dikenali: ${response.body}');
        }
      } else {
        final String message =
            data['meta']?['message'] ??
            data['error'] ??
            data['message'] ??
            'Login Google gagal (${response.statusCode})';
        throw Exception(message);
      }
    } catch (e) {
      print('Network Error: $e');
      throw Exception('Gagal memproses data: $e');
    }
  }
}
