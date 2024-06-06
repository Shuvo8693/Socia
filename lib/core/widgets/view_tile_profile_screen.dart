import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ViewTile extends StatelessWidget {
  const ViewTile({
    super.key,
    required this.onTap,
    required this.text,
    required this.svgIcon,
    this.boxWidth, this.rightPadding, this.leftPadding,
  });

  final Function() onTap;
  final String text;
  final String svgIcon;
  final double? boxWidth;
  final double? rightPadding;
  final double? leftPadding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: boxWidth ?? 130,
      child: ListTile(
        onTap: onTap,
        leading: SvgPicture.asset(
          svgIcon,
          height: 16,
          width: 16,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onPrimary, BlendMode.srcIn),
        ),
        title: Text(text,style: const TextStyle(fontWeight: FontWeight.w500),),
        contentPadding: EdgeInsets.only(right: rightPadding??2,left: leftPadding??2 ),
      ),
    );
  }
}
