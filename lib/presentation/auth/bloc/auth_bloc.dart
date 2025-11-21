import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mini_project1/core/data/datasource/auth_remote_datasource.dart';
import 'package:mini_project1/core/data/service/session_service.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // BLoC membutuhkan Datasource untuk memanggil API
  final AuthRemoteDatasource _authDatasource;
  final SessionService _sessionService;
  String? _selectedRole;

  // 2. PERBARUI CONSTRUCTOR
  AuthBloc(this._authDatasource, this._sessionService) : super(AuthInitial()) {
    // Saat event 'AuthCheckEmailPressed' masuk, panggil method '_onCheckEmail'
    on<AuthCheckEmailPressed>(_onCheckEmail);
    on<AuthLoginPressed>(_onLogin);
    on<AuthRegisterPressed>(_onRegister);
    on<AuthSendOtpEmailPressed>(_onSendOtpEmail);
    on<AuthRoleSelected>(_onRoleSelected);
    on<AuthVerifyOtpPressed>(_onVerifyOtp);
    on<AuthGoogleSignInPressed>(_onGoogleSignIn);
    on<AuthLogoutPressed>(_onLogout);
  }

  // Ini adalah logika bisnis Anda
  Future<void> _onCheckEmail(
    AuthCheckEmailPressed event,
    Emitter<AuthState> emit,
  ) async {
    // Keluarkan state Loading agar UI bisa menampilkan spinner
    emit(AuthEmailCheckLoading());
    try {
      // Panggil API melalui datasource
      final isRegistered = await _authDatasource.checkEmail(event.email);

      // Jika sukses, keluarkan state Success beserta datanya
      emit(AuthEmailCheckSuccess(isRegistered));
    } catch (e) {
      // Jika gagal (error jaringan, server down, dll),
      // keluarkan state Failure beserta pesan errornya
      emit(AuthEmailCheckFailure(e.toString()));
    }
  }

  Future<void> _onLogin(AuthLoginPressed event, Emitter<AuthState> emit) async {
    emit(AuthLoginLoading());
    try {
      // 1. Dapatkan token dari API
      final token = await _authDatasource.login(event.email, event.password);

      // 2. SIMPAN TOKEN KE HIVE (INI YANG HILANG)
      await _sessionService.saveToken(token);

      // 3. Keluarkan state sukses
      emit(AuthLoginSuccess(token)); // Kirim token ke state
    } catch (e) {
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onRegister(
    AuthRegisterPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthRegisterLoading());
    try {
      if (_selectedRole == null) {
        // <-- GANTI INI
        throw Exception("Role belum dipilih.");
      }
      final token = await _authDatasource.register(
        email: event.email,
        name: event.name,
        phone: event.phone,
        password: event.password,
        role:
            _selectedRole!, // <-- Pastikan Anda mengirim 'role' (bukan 'roleHash')
      );

      print("--- TOKEN REGISTRASI BARU (UNTUK POSTMAN) ---");
      print(token);
      print("---------------------------------------------");

      // SIMPAN TOKEN KE HIVE
      await _sessionService.saveToken(token);

      // Keluarkan state sukses (untuk memicu modal)
      emit(AuthRegisterSuccess());
    } catch (e) {
      emit(AuthRegisterFailure(e.toString()));
    }
  }

  // --- 5. TAMBAHKAN METHOD _onSendOtpEmail ---
  Future<void> _onSendOtpEmail(
    AuthSendOtpEmailPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthOtpSending());
    try {
      await _authDatasource.sendOtpEmail(event.email);
      emit(AuthOtpSentSuccess());
    } catch (e) {
      // --- PERBAIKANNYA ---
      // Keluarkan state error agar UI bisa menampilkan Snackbar
      emit(AuthRegisterFailure(e.toString()));
      // (Atau buat state baru: 'AuthOtpFailure')
    }
  }

  // Method baru untuk menyimpan role
  void _onRoleSelected(AuthRoleSelected event, Emitter<AuthState> emit) {
    _selectedRole = event.role; // <-- Sesuaikan
  }

  Future<void> _onVerifyOtp(
    AuthVerifyOtpPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthOtpVerifying());
    try {
      // Panggil method baru (hanya perlu event.otp)
      await _authDatasource.verifyEmailOtp(event.otp);
      emit(AuthOtpVerifySuccess());
    } catch (e) {
      // Ini sekarang akan melempar pesan error yang BENAR dari API
      emit(AuthOtpVerifyFailure(e.toString()));
    }
  }

  // Method handler untuk Google Sign In
  Future<void> _onGoogleSignIn(
    AuthGoogleSignInPressed event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoginLoading());
    try {
      if (_selectedRole == null) {
        throw Exception("Role hash belum dipilih.");
      }

      // _selectedRole harus berupa string "jobseeker" atau "company"
      // BUKAN hash yang sudah di-hash
      final token = await _authDatasource.loginWithGoogle(
        googleTokenId: event.idToken,
        role: _selectedRole!, // "jobseeker" atau "company"
      );

      await _sessionService.saveToken(token);
      emit(AuthLoginSuccess(token));
    } catch (e) {
      print('Google Sign In Error: $e');
      emit(AuthLoginFailure(e.toString()));
    }
  }

  Future<void> _onLogout(
    AuthLogoutPressed event,
    Emitter<AuthState> emit,
  ) async {
    // 1. Hapus token dari Hive
    await _sessionService.deleteToken();

    // 2. Kembalikan state ke AuthInitial
    //    (Kita akan gunakan ini untuk memicu navigasi)
    emit(AuthInitial());
  }
}
