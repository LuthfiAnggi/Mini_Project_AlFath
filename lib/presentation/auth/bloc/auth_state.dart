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
  // Tambahkan properti token
  final String token;
  const AuthLoginSuccess(this.token);

  @override
  List<Object> get props => [token];
}

class AuthLoginFailure extends AuthState {
  final String error;
  const AuthLoginFailure(this.error);
}

// State saat registrasi sedang diproses
class AuthRegisterLoading extends AuthState {}

// State saat registrasi sukses (ini akan memicu bottom sheet)
class AuthRegisterSuccess extends AuthState {}

// State saat registrasi gagal
class AuthRegisterFailure extends AuthState {
  final String error;
  const AuthRegisterFailure(this.error);
}

// State saat OTP sedang dikirim
class AuthOtpSending extends AuthState {}

// State saat OTP sukses terkirim (ini akan memicu navigasi)
class AuthOtpSentSuccess extends AuthState {}

// State saat OTP sedang diverifikasi
class AuthOtpVerifying extends AuthState {}

// State saat OTP sukses (saatnya ke HomePage)
class AuthOtpVerifySuccess extends AuthState {}

// State saat OTP gagal (ini adalah 'warning' Anda)
class AuthOtpVerifyFailure extends AuthState {
  final String error;
  const AuthOtpVerifyFailure(this.error);
}