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

// TODO: Tambahkan event lain nanti, misalnya:
// class AuthLoginPressed extends AuthEvent { ... }
// class AuthRegisterPressed extends AuthEvent { ... }