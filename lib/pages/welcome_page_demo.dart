import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:socail/values/app_assets.dart';
import 'package:socail/values/app_colors.dart';
import 'package:socail/values/app_styles.dart';
import 'package:socail/widgets/app_buttons.dart';
class WelcomePage_Demo extends StatelessWidget {
  const WelcomePage_Demo({Key? key}) : super(key: key);

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
                const SizedBox(height: 44.0,),
                AppButton(
                  onPressed: (){},
                  nameButton: 'Log In',
                  colorButton: AppColors.likeColor,
                  colorText: AppColors.redTextColor,
                  gradient: const LinearGradient(colors: [Color(0xFFFFFFFF),Color(0xFFFFFFFF)]),
                ),

                const SizedBox(height: 10.0,),
                AppButton(
                  onPressed: (){},
                  nameButton: 'Sign Up',
                  colorText: AppColors.likeColor,
                  gradient: const LinearGradient(colors: [Color(0xFFF78361),Color(0xFFF54B64)]),
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
                        _signInWithGoogle();
                        print('onTaped');
                      },
                        child: Image.asset(AppAssets.icFace)),
                    const SizedBox(width: 26.0,),
                    Image.asset(AppAssets.icCall),
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
  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    print('token ${googleAuth?.accessToken}');

    // Once signed in, return the UserCredential
    final firebaseAccount = await FirebaseAuth.instance.signInWithCredential(credential);
    print('FirebaseAccount=$firebaseAccount');
    return firebaseAccount;
  }
}
