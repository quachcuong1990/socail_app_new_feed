import 'package:flutter/services.dart';

import '../auth_plugin/auth_plugin.dart';
import '../auth_plugin/gmail_login.dart';
import '../auth_provider/gmail_auth_provider.dart';
import '../models/login_data.dart';
import 'app_auth.dart';
import 'auth_service.dart';

class AppAuthService implements AuthService{
  final _appAuth = AppAuth();

  @override
  Future<LoginData?> loginWithGmail() async{
    final _authGmail = AuthGmail();
    final authResult = await _authGmail.login();
    if (authResult.accessToken != null) {
      final result = await _appAuth.signInWithCredential(
        GmailAuthProvider.getCredential(accessToken: authResult.accessToken),
      );
      return result;
    }

    return handleError(authResult);
  }

  LoginData handleError(AuthResult authResult){
    if(authResult.loginStatus == LoginStatus.cancelledByUser){
      throw PlatformException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
    throw PlatformException(
      code: 'ERROR_BY_CONFIG',
      message: authResult.errMessage,
    );
  }
}