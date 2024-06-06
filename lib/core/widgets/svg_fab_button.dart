import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../config/theme/app_color.dart';

class SvgFabButton extends StatelessWidget {
  const SvgFabButton({
    super.key,
    required this.onPressed,
    required this.assetPath,
    this.fabBgColor,
  });

  final Function() onPressed;
  final String assetPath;
  final Color? fabBgColor;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: fabBgColor ?? AppColors.notificationAndMessageBgColor,
      heroTag: UniqueKey(),
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      onPressed: onPressed,
      child: SvgPicture.asset(
        assetPath,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : Colors.black,
            BlendMode.srcIn),
      ),
    );
  }
}
