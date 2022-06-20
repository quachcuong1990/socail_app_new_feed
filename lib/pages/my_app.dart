import 'package:flutter/material.dart';
import 'package:socail/pages/login_page.dart';
import 'package:socail/pages/sign_up_page.dart';
import 'package:socail/pages/welcome_page.dart';
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
    );
  }
}
