import 'package:flutter/material.dart';
import 'package:socail/values/app_colors.dart';
import 'package:socail/values/app_fonts.dart';
class AppStyles{
  static  TextStyle h1 = const TextStyle(fontSize: 44,fontFamily: AppFont.aven,
      color: AppColors.likeColor,fontWeight: FontWeight.bold);
  static  TextStyle h2 = const TextStyle(fontSize: 17,fontFamily: AppFont.aven,
      color: AppColors.likeColor);
  static  TextStyle h3 = const TextStyle(fontSize: 15,fontFamily: AppFont.aven,
      color: AppColors.redTextColor,fontWeight: FontWeight.bold);
}