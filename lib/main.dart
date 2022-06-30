import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socail/modules/firebase/widgets/firebase_initializer.dart';
import 'package:socail/pages/my_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:socail/src/app_old.dart';
import 'package:socail/src/settings/settings_controller.dart';
import 'package:socail/src/settings/settings_service.dart';

void main() async {
  final settingsController = SettingsController(SettingsService());

  // Load the user's preferred theme while the splash screen is displayed.
  // This prevents a sudden theme change when the app is first displayed.
  await settingsController.loadSettings();
  runApp(
    FirebaseInitializer(
      child: MyAppFirebase(settingsController: settingsController,),
    ),
  );}


