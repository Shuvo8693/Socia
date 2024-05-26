import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgInkButton extends StatelessWidget {
  const SvgInkButton({
    super.key,
    required this.assetPath,
    this.top,
    this.left,
    this.right,
    this.bottom,
    this.color,
    required this.onTap, this.pictureWidth, this.pictureHeight,
  });

  final String assetPath;
  final Function() onTap;
  final double? top;
  final double? left;
  final double? right;
  final double? bottom;
  final Color? color;
  final double? pictureWidth;
  final double? pictureHeight;

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
          child: SvgPicture.asset(
            assetPath,
            width: pictureWidth ?? 24,
            height: pictureHeight ?? 24,
            colorFilter: ColorFilter.mode(color ?? Colors.black, BlendMode.srcIn),
          )),
    );
  }
}
