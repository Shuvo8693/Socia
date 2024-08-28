import 'package:flutter/material.dart';

class CheckBox extends StatelessWidget {
  const CheckBox({
    super.key,
    required bool check,
    required this.onPressed,
  }) : _check = check;

  final  bool _check;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: _check
              ? const Icon(
            Icons.check_box,
            color: Color(0xFF8FAEFF),
          )
              : const Icon(
            Icons.check_box_outline_blank,
          ),
        ),
        const Text('Save Password')
      ],
    );
  }
}