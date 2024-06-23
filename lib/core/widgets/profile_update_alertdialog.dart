import 'package:flutter/material.dart';

import '../../config/theme/app_color.dart';
import '../../config/theme/app_icons.dart';
import 'button_text.dart';

class ProfileUpdateDialog extends StatelessWidget {
  const ProfileUpdateDialog({
    super.key,
    required this.onPressed,
  });

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: Image.asset(
        AppIcons.profileUpdate,
        height: 34,
        width: 34,
      ),
      title: const Text(
        'Profile Created',
        style: TextStyle(fontWeight: FontWeight.w700, fontSize: 16),
      ),
      content: const Text(
        'update your name, profile image, additional number',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontWeight: FontWeight.w400,
            color: AppColors.alertPostContentColor),
      ),
      actions: [
        Center(
          child: Column(
            children: [
              SizedBox(
                  height: 36,
                  width: 224,
                  child: ElevatedButton(
                      onPressed: onPressed, child: const Text('Update'))),
              const SizedBox(
                height: 8,
              ),
              SizedBox(
                height: 36,
                width: 224,
                child: ButtonText(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  textA: 'Skip',
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
