
import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_sizes.dart';
import 'package:socia/core/utility/logo.dart';
import 'button_text.dart';
import 'common_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    SizeConfig.init(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height:SizeConfig.desktopScreen? 70: 60,
                  width: 350,
                  child: Image.asset(AppLogo.logo)),
              const SizedBox(height: 48,),
              CommonButton(onPressed: () {  }, text: 'Create Account',),
              const SizedBox(height: 12,),
              ButtonText(onPressed: () {  }, textA: 'Log In', textB: '  ˅',),

            ],
          ),
        ),
      ),
    );
  }
}





