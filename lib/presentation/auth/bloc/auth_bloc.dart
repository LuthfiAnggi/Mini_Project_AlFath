import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// TODO: Ganti import ini dengan path datasource Anda yang benar
import 'package:mini_project1/core/data/datasource/auth_remote_datasource.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  // 1. TAMBAHKAN DEPENDENCY
  // BLoC membutuhkan Datasource untuk memanggil API
  final AuthRemoteDatasource _authDatasource;

  // 2. PERBARUI CONSTRUCTOR
  // Kita "menyuntikkan" (inject) datasource ke dalam BLoC
  AuthBloc(this._authDatasource) : super(AuthInitial()) {
    
    // 3. DAFTARKAN EVENT HANDLER
    // Saat event 'AuthCheckEmailPressed' masuk, panggil method '_onCheckEmail'
    on<AuthCheckEmailPressed>(_onCheckEmail);
    on<AuthLoginPressed>(_onLogin);

    // TODO: Daftarkan event lain nanti
    // on<AuthLoginPressed>(_onLogin);
  }

  // 4. IMPLEMENTASIKAN METHOD HANDLER
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


  Future<void> _onLogin(
  AuthLoginPressed event,
  Emitter<AuthState> emit,
) async {
  emit(AuthLoginLoading());
  try {
    final token = await _authDatasource.login(event.email, event.password);
    emit(AuthLoginSuccess(/* token */)); // Kirim token jika perlu
  } catch (e) {
    emit(AuthLoginFailure(e.toString()));
  }
}

  // TODO: Tambahkan method handler lain nanti
  // Future<void> _onLogin(...) async { ... }
  // Future<void> _onRegister(...) async { ... }
}