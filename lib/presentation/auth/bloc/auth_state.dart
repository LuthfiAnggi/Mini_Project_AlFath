part of 'auth_bloc.dart';

// Class dasar untuk semua state
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

// State awal saat BLoC baru dibuat
class AuthInitial extends AuthState {}

// State saat sedang memanggil API checkEmail
class AuthEmailCheckLoading extends AuthState {}

// State jika API checkEmail SUKSES
class AuthEmailCheckSuccess extends AuthState {
  // Kita kirim balik hasilnya (terdaftar atau tidak)
  final bool isRegistered;

  const AuthEmailCheckSuccess(this.isRegistered);

  @override
  List<Object> get props => [isRegistered];
}

// State jika API checkEmail GAGAL
class AuthEmailCheckFailure extends AuthState {
  final String error;

  const AuthEmailCheckFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthLoginLoading extends AuthState {}

class AuthLoginSuccess extends AuthState {
  // TODO: Simpan token atau data user di sini
  // final String token; 
  // const AuthLoginSuccess(this.token);
} 

class AuthLoginFailure extends AuthState {
  final String error;
  const AuthLoginFailure(this.error);
}
// TODO: Tambahkan state lain nanti, misalnya:
// class AuthLoginLoading extends AuthState {}
// class AuthLoginSuccess extends AuthState {}
// class AuthLoginFailure extends AuthState {}