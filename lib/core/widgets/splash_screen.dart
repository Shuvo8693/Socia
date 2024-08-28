import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_sizes.dart';
import 'package:socia/core/extention/size_extention.dart';
import 'package:socia/core/routing/router.dart';
import 'package:socia/core/utility/logo.dart';
import 'package:socia/core/widgets/spacing/spacing.dart';

import 'button/common_button.dart';
import 'button_text.dart';

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
                height: SizeConfig.desktopScreen ? 70.rH : 60.rH,
                width: 350.rW,
                child: Image.asset(
                  AppLogo.logo,
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
              ),
              verticalSpace(48.rH),
              CommonButton(
                onPressed: () {
                  return Routers.pushNamed(
                      routeName: Routers.logInScreen,
                      queryParam: {'isLogin': false});
                },
                text: 'Create Account',
              ),
              verticalSpace(12.rH),
              ButtonText(
                onPressed: () {
                  return Routers.pushNamed(
                      routeName: Routers.logInScreen,
                      queryParam: {'isLogin': true});
                },
                textA: 'Log In',
                textB: '  ˅',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
