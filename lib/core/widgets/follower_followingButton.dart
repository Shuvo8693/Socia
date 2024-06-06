import 'package:flutter/material.dart';

class FollowerFollowingButton extends StatelessWidget {
  const FollowerFollowingButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.isSelected,
  });

  final String text;
  final Function() onPressed;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
            decoration: BoxDecoration(
              border: Border(
                  bottom: isSelected
                      ?  BorderSide(width: 3.0, color: Theme.of(context).colorScheme.onPrimary)
                      : BorderSide.none),
            ),
            child: Text(
              text,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
              ),
            )),
      ),
    );
  }
}
