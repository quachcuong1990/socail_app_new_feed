import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../blocs/app_state_bloc.dart';
import '../../../common/widgets/stateless/error_popup.dart';
import '../../../providers/bloc_provider.dart';
import '../../../values/app_assets.dart';
import '../../../values/app_colors.dart';
import '../../../values/app_styles.dart';
import '../../../widgets/app_buttons.dart';
import '../bloc/authentication_bloc.dart';
import '../enum/login_state.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  AppStateBloc? get appStateBloc => BlocProvider.of<AppStateBloc>(context);
  AuthenticationBloc? get authenBloc =>
      BlocProvider.of<AuthenticationBloc>(context);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/fashion.jpg'),
                  opacity: 0.3,
                  fit: BoxFit.cover),
              gradient: LinearGradient(
                  begin:Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.likeColor,GradientAppColor.bg_copy]
              )
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 25.0,right: 25.0),
                  child: Text('Find new friends nearby',
                      style: AppStyles.h1
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30,top: 14,right: 30,),
                  child: Text('With milions of users all over the world, '
                      'we gives you the ability to connect with people no matter where you are.',
                    style: AppStyles.h2,),
                ),
                const SizedBox(height: 44.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: AppButton(
                    onPressed: (){
                      Navigator.pushNamed(context, '/sign-up-page');
                    },
                    nameButton: 'Log In',
                    colorButton: AppColors.likeColor,
                    colorText: AppColors.redTextColor,
                    gradient: const LinearGradient(colors: [Color(0xFFFFFFFF),Color(0xFFFFFFFF)]),
                  ),
                ),

                const SizedBox(height: 10.0,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: AppButton(
                    onPressed: (){},
                    nameButton: 'Sign Up',
                    colorText: AppColors.likeColor,
                    gradient: const LinearGradient(colors: [Color(0xFFF78361),Color(0xFFF54B64)]),
                  ),
                ),
                const SizedBox(height: 48.0,),
                const Text('Or log in with',
                  style: TextStyle(color: Colors.white,fontSize: 13.0
                  ),
                ),
                const SizedBox(height: 22.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                        onTap: (){
                          _signInWithGmail();
                          print('onTaped');
                        },
                        child: Image.asset(AppAssets.icGG)),
                    const SizedBox(width: 26.0,),
                    Image.asset(AppAssets.icFace),
                    const SizedBox(width: 26.0,),
                    Image.asset(AppAssets.icTwister),
                  ],
                ),
                Container(
                  width: 135.0,
                  height: 5.0,
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 8.0,top: 46.75),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _signInWithGmail() async {
    // loading!(true);
    try {
      final loginState = await authenBloc!.loginWithGmail();
      switch (loginState) {
      case LoginState.success:
        return _changeAppState();
      case LoginState.newUser:
        // handle flow newUser
        break;
      default:
        break;
    }
    } on PlatformException catch (e) {
      // loading!(false);
      _handleErrorPlatformException(e);
    } catch (e) {
      _showDialog('Something went wrong!!!');
    }
  }

  void _changeAppState() {
    appStateBloc!.changeAppState(AppState.authorized);
  }

  void _handleErrorPlatformException(PlatformException e) {
    if (e.code != 'ERROR_ABORTED_BY_USER') {
      _showDialog(e.message ?? '');
    }
  }

  void _showDialog(String content) {
    showDialog(
      context: context,
      builder: (ctx) => ErrorPopup(content: content),
    );
  }
}
