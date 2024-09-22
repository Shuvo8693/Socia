import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:socia/config/theme/app_color.dart';

class SvgInkButton extends StatelessWidget {
  const SvgInkButton({
    super.key,
    required this.assetPath,
    this.top,
    this.left,
    this.right,
    this.bottom,
    required this.onTap,
    this.pictureWidth,
    this.pictureHeight,
    this.isBGSurfaceWhite,
    this.isColorRed,
  });

  final String assetPath;
  final Function() onTap;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final double? pictureWidth;
  final double? pictureHeight;
  final bool? isBGSurfaceWhite;
  final bool? isColorRed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: top ?? 0,
          left: left ?? 0,
          right: right ?? 0,
          bottom: bottom ?? 0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: SvgPicture.asset(
          assetPath,
          width: pictureWidth ?? 24,
          height: pictureHeight ?? 24,
          colorFilter: ColorFilter.mode(
              Theme.of(context).brightness == Brightness.dark
                  ? isBGSurfaceWhite != true
                      ? Colors.white
                      : Colors.grey.shade700
                  :isColorRed==true?AppColors.heartColor :Colors.black,
              BlendMode.srcIn),
        ),
      ),
    );
  }
}
