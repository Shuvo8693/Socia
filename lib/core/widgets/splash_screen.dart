import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socia/config/theme/app_sizes.dart';
import 'package:socia/core/utility/logo.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_event.dart';
import 'package:socia/features/authentication/presentation/bloc/auth_state.dart';
import 'package:socia/features/authentication/presentation/screen/login_screen.dart';
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
                  height: SizeConfig.desktopScreen ? 70 : 60,
                  width: 350,
                  child: Image.asset(
                    AppLogo.logo,
                    color: Theme.of(context).colorScheme.onPrimary,
                  )),
              const SizedBox(
                height: 48,
              ),
              CommonButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen(
                                isLogin: false,
                              )));
                },
                text: 'Create Account',
              ),
              const SizedBox(
                height: 12,
              ),
              ButtonText(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LogInScreen(
                                isLogin: true,
                              )));
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
