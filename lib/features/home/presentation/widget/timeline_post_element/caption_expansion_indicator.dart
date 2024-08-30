import 'package:flutter/material.dart';
import 'package:socia/core/extention/size_extention.dart';

class CaptionExpansionIndicator extends StatelessWidget {
  const CaptionExpansionIndicator({
    super.key,
    required this.isExpanded,
    required this.onPressed,
  });

  final bool isExpanded;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.rW),
      child: GestureDetector(
        onTap: onPressed,
        child: isExpanded
            ? const Text('See less', style: TextStyle(color: Colors.blueAccent))
            : const Text(
                'See more',
                style: TextStyle(color: Colors.blueAccent),
              ),
      ),
    );
  }
}
