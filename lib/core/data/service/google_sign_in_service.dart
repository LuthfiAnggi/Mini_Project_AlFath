import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static final _googleSignIn = GoogleSignIn(
    
    clientId:
        //'382536456671-inurbfoil5ko5ausharte74g7ibep6fj.apps.googleusercontent.com',
        //'382536456671-5tsaha8kv6sat6nrgecd2gbnrbc814oq.apps.googleusercontent.com',
        '562171628138-qbcupln9r6jf7cn6u6eon742j805bfs9.apps.googleusercontent.com', 
     
  );

  static Future<GoogleSignInAccount?> login() async {
    print("DEBUG: GoogleSignInService.login() dipanggil");
    try {
      print("DEBUG: Memaksa disconnect() agar popup muncul...");
      await _googleSignIn.disconnect().catchError((_) {
        print("DEBUG: disconnect() error tapi diabaikan (normal)");
      });
      print("DEBUG: Memanggil signIn() ...");
      final result = await _googleSignIn.signIn();
      print("DEBUG: HASIL signIn(): $result");
      return result;
    } catch (e) {
      print("ERROR GoogleSignInService.login(): $e");
      rethrow;
    }
  }

  static Future logout() async {
    print("DEBUG: GoogleSignIn.signOut() dipanggil");
    return _googleSignIn.signOut();
  }
}
