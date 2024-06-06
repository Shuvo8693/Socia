import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:socia/config/theme/app_color.dart';
import 'package:socia/config/theme/app_icons.dart';
import 'package:socia/config/theme/app_sizes.dart';

class ButtonText extends StatelessWidget {
  const ButtonText({
    super.key,
    required this.onPressed,
    required this.textA,
    this.width,
    this.fontSize,
    this.fontWeight,
    this.textB,
    this.needColor,
  });

  final Function() onPressed;
  final String textA;
  final String? textB;
  final double? width;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? needColor;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:  36,
      width:width?? 295,
      child: TextButton(
          onPressed: onPressed,
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(textA,style:  TextStyle(fontSize:fontSize?? 14,fontWeight: fontWeight?? FontWeight.w700,color: needColor ?? AppColors.primaryColor ),),
              const SizedBox(width: 8,),
              SvgPicture.asset(AppIcons.downArrow,width: 12.5,height: 6.25,colorFilter: const ColorFilter.mode(AppColors.primaryColor, BlendMode.srcIn),)
            ],
          )),
    );
  }
}