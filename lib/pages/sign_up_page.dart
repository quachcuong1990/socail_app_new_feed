import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:socail/modules/authentication/bloc/my_form_bloc.dart';
import 'package:socail/modules/authentication/widgets/custom_textfield.dart';
import 'package:socail/values/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socail/widgets/app_buttons.dart';

import '../values/app_styles.dart';
class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children:[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin:Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [GradientAppColor.bg_copy2,GradientAppColor.bg_copy]
                ),
                image: DecorationImage(
                  image: AssetImage('assets/images/bg_img_signup.png'),
                  opacity: 0.3,
                  fit: BoxFit.cover,
                )
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0.0,
                automaticallyImplyLeading: false,
                centerTitle: false,
                titleSpacing: 0.0,
                leading: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/icons/back.svg',color: Colors.white,
                    ),
                  ),
                ),

              ),
              body: BlocProvider(
                create: (_)=>MyFormBloc(),
                child: const MyForm()
              )
          ),
        ]
      ),
    );
  }
}



class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: const <Widget>[
                Icon(Icons.info),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Form Submitted Successfully!',
                      softWrap: true,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              child: const Text('OK'),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }
}
class MyForm extends StatefulWidget {
  const MyForm({Key? key}) : super(key: key);

  @override
  State<MyForm> createState() => _MyFormState();
}

class _MyFormState extends State<MyForm> {
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<MyFormBloc>().add(PasswordUnfocused());
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<MyFormBloc,MyFormState>(
        listener: (context,state){
          if (state.status.isSubmissionSuccess) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            showDialog<void>(
              context: context,
              builder: (_) => const SuccessDialog(),
            );
          }
          if (state.status.isSubmissionInProgress) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Submitting...')),
              );
          }
        },

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 50,),
              Text('Create an account',style: AppStyles.h4),
              SizedBox(height: 70,),
              // EmailInput(focusNode: _emailFocusNode,),
              CustomTextField(
                focusNode: _emailFocusNode,
                radius: 22.0,
                widthBorder: 0.0,
                hintText: 'Username',
                helperText: 'A complete, valid email e.g. joe@gmail.com',
              ),
              SizedBox(
                height: 10,
              ),

              // CustomTextField(
              //   focusNode: _emailFocusNode,
              //   radius: 22.0,
              //   widthBorder: 0.0,
              //   hintText: 'Email',
              //   keyboardType: TextInputType.emailAddress,
              // ),

              SizedBox(
                height: 10,
              ),
              // CustomTextField(
              //   radius: 22.0,
              //   widthBorder: 0.0,
              //   hintText: 'Phone',
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CustomTextField(
              //   radius: 22.0,
              //   widthBorder: 0.0,
              //   hintText: 'Date of birth',
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // CustomTextField(
              //   radius: 22.0,
              //   widthBorder: 0.0,
              //   hintText: 'Password',
              // ),
              SizedBox(
                height: 40,
              ),
              AppButton(
                onPressed: (){},
                nameButton: 'Sign Up',
                colorText: AppColors.likeColor,
                gradient: const LinearGradient(colors: [Color(0xFFF78361),Color(0xFFF54B64)]),
              ),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(bottom: 30,right: 50,left: 53),
                      alignment: Alignment.bottomCenter,
                      child: Text('By clicking Sign up you agree to the following Terms and Conditions without reservation ',style: AppStyles.h5,textAlign: TextAlign.center,)
                  ))
            ],
          ),
        )

    );
  }
}

