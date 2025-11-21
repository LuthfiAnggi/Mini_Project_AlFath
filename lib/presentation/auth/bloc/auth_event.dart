part of 'auth_bloc.dart';

// Class dasar untuk semua event
abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

// Event yang akan dipanggil saat tombol "Lanjut"
// di halaman input email ditekan.
class AuthCheckEmailPressed extends AuthEvent {
  final String email;

  const AuthCheckEmailPressed(this.email);

  @override
  List<Object> get props => [email];
}

class AuthLoginPressed extends AuthEvent {
  final String email;
  final String password;
  const AuthLoginPressed(this.email, this.password);
}

// Event untuk menekan tombol "Daftar"
class AuthRegisterPressed extends AuthEvent {
  final String email;
  final String name;
  final String phone;
  final String password;


  const AuthRegisterPressed({
    required this.email,
    required this.name,
    required this.phone,
    required this.password,
  });
}

// Event baru untuk menyimpan role
class AuthRoleSelected extends AuthEvent {
  final String role; 
  const AuthRoleSelected(this.role);

  @override
  List<Object> get props => [role];
}

// Event untuk menekan tombol "Kirim OTP melalui email"
class AuthSendOtpEmailPressed extends AuthEvent {
  final String email;
  const AuthSendOtpEmailPressed({required this.email});
}

// Event untuk menekan tombol "Daftar" (verifikasi OTP)
class AuthVerifyOtpPressed extends AuthEvent {
  final String otp;
  const AuthVerifyOtpPressed({required this.otp});

  @override
  List<Object> get props => [otp];
}

// Event untuk menekan tombol "Lanjutkan dengan Google"
class AuthGoogleSignInPressed extends AuthEvent {
  final String idToken; // Ini adalah token dari Google
  const AuthGoogleSignInPressed(this.idToken);

  @override
  List<Object> get props => [idToken];
}

class AuthLogoutPressed extends AuthEvent {
  const AuthLogoutPressed();
}