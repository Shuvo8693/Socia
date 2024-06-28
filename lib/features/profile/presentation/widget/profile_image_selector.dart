import 'package:flutter/material.dart';
import '../../../../config/theme/app_color.dart';
import '../../../../config/theme/app_icons.dart';

class ProfileImageSelector extends StatelessWidget {
  const ProfileImageSelector({
    super.key, required this.onTap,
  });
 final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: 35,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(20),
          border: const Border(
            top: BorderSide(width: 2, color: Colors.white),
            left: BorderSide(width: 2, color: Colors.white),
            bottom: BorderSide(width: 2, color: Colors.white),
            right: BorderSide(width: 2, color: Colors.white),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Image.asset(
            AppIcons.profileCameraPng,
            color: Colors.white,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}