import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_color.dart';

class FoUnfMsgButton extends StatelessWidget {
  const FoUnfMsgButton({
    super.key,
    this.text,
    this.isBgColorGrey,
    required this.onPressed,
    this.paddingHorizontal,
    this.isReverseBgColor,
    this.isFollow,
  });

  final Function() onPressed;
  final String? text;
  final bool? isBgColorGrey;
  final double? paddingHorizontal;
  final bool? isReverseBgColor;
  final bool? isFollow;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ButtonStyle(
            backgroundColor: isReverseBgColor == true
                ? MaterialStatePropertyAll(isBgColorGrey == true
                    ? AppColors.followUnfollowMessageColor
                    : AppColors.textFieldBorderSideAndSenderBarColor)
                : MaterialStatePropertyAll(isBgColorGrey != true
                    ? AppColors.textFieldBorderSideAndSenderBarColor
                    : AppColors.followUnfollowMessageColor),
            foregroundColor: isReverseBgColor == true
                ? MaterialStatePropertyAll(
                    isBgColorGrey == true ? Colors.black : Colors.white)
                : MaterialStatePropertyAll(
                    isBgColorGrey != true ? Colors.white : Colors.black),
            padding: MaterialStatePropertyAll(EdgeInsets.symmetric(
              horizontal: paddingHorizontal ?? 8,
            ))),
        onPressed: onPressed,
        child: isReverseBgColor != true
            ? Text(text ?? 'enter title')
            : isFollow != true
                ? const Text('Unfollow')
                : const Text('Follow'));
  }
}
