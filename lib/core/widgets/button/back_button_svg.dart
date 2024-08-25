import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/core/widgets/button/svg_ink_button.dart';


class BackButtonSvg extends StatelessWidget {
  const BackButtonSvg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, top: 16, bottom: 16),
      child: SvgInkButton(
          pictureWidth: 24,
          pictureHeight: 24,
          assetPath: AppIcons.leftArrow,
          onTap: () {
            Navigator.pop(context);
          }),
    );
  }
}
