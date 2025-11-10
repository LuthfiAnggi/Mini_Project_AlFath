// File: lib/core/data/service/session_service.dart
import 'package:hive_flutter/hive_flutter.dart';

class SessionService {
  final Box _authBox = Hive.box('auth');
  static const String _tokenKey = 'token';

  // Method untuk MENYIMPAN token
  Future<void> saveToken(String token) async {
    await _authBox.put(_tokenKey, token);
  }

  // Method untuk MENGAMBIL token
  String? getToken() {
    return _authBox.get(_tokenKey);
  }

  // Method untuk MENGHAPUS token (untuk logout)
  Future<void> deleteToken() async {
    await _authBox.delete(_tokenKey);
  }
}