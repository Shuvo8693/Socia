import 'package:flutter/material.dart';

class SizeConfig{
  static late double screenHeight;
  static late double screenWidth;
  static late bool mobileScreen;
  static late bool tabletScreen;
  static late bool desktopScreen;

 static init(BuildContext context){
     screenHeight= MediaQuery.of(context).size.height;
     screenWidth= MediaQuery.of(context).size.width;

    mobileScreen= screenWidth < 600;
    tabletScreen = screenWidth >= 600 && screenWidth < 1200;
    desktopScreen= screenWidth >= 1200;
  }

  static double adjustScreenHeight(double height){
    final screenHeight= SizeConfig.screenHeight;
    return (height/812.0) * screenHeight;
  }

  static double adjustScreenWidth(double width){
    final screenWidth= SizeConfig.screenWidth;
    return (width/375.0) * screenWidth;
  }
}