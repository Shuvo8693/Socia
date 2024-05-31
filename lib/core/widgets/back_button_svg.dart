import 'package:flutter/material.dart';
import 'package:socia/core/widgets/svg_ink_button.dart';

import '../../config/theme/app_icons.dart';

class BackButtonSvg extends StatelessWidget {
  const BackButtonSvg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgInkButton(
        pictureWidth: 24,
        pictureHeight: 24,
        assetPath: AppIcons.leftArrow,
        onTap: () {
          Navigator.pop(context);
        });
  }
}