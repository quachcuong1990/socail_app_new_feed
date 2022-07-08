import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:socail/providers/bloc_provider.dart';
import 'auth_plugin.dart';

class AuthGmail implements AuthLogin {
  static final AuthGmail _instance = AuthGmail.internal();
  late GoogleSignIn _googleSignIn;

  factory AuthGmail() {
    return _instance;
  }

  @override
  AuthGmail.internal() {
    _googleSignIn = GoogleSignIn();
  }

  @override
  Future<bool> isLoggedIn() {
    return _googleSignIn.isSignedIn();
  }

  @override
  Future<AuthResult> login() async {
    await _googleSignIn.signOut(); // force logout
    try {
      final googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount == null) {
        return AuthResult(LoginStatus.cancelledByUser, null);
      }
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;

      print('Token : ${googleSignInAuthentication.accessToken}');
      final credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      final firebaseAccount = await FirebaseAuth.instance.signInWithCredential(credential);
      final user = firebaseAccount.user;
      print('photo: ===${user?.photoURL}');
      print('FirebaseAccountvip=$firebaseAccount');
      return AuthResult(
        LoginStatus.loggedIn,
        googleSignInAuthentication.accessToken,
      );
    } catch (e) {
      return AuthResult(LoginStatus.error, null);
    }
  }

  @override
  Future<void> logout() {
    return _googleSignIn.signOut();
  }
}
