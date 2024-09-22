import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../config/theme/app_color.dart';
import '../../../config/theme/app_icons.dart';

class BlueTextButton extends StatelessWidget {
  const BlueTextButton({
    super.key,
    required this.text,
    required this.isIconSet,
    required this.onPressed,
  });

  final Function() onPressed;
  final String text;
  final bool isIconSet;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
          ),
          const SizedBox(
            width: 3,
          ),
          isIconSet
              ? SvgPicture.asset(
                  AppIcons.rightArrow,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                      AppColors.primaryColor, BlendMode.srcIn),
                )
              : const SizedBox.shrink()
        ],
      ),
    );
  }
}
