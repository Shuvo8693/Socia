import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_sizes.dart';

class CommonButton extends StatelessWidget {
   const CommonButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.desktopScreen ? 45 : 36,
      width: 295,
      child: ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
