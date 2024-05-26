import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_sizes.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key, required this.onPressed,
  });
  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.desktopScreen? 45: 36,
      width:  295,
      child: TextButton(
          onPressed: onPressed,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Log in',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
              Text('  ˅',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w900)),
            ],
          )),
    );
  }
}