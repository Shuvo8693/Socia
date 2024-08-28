import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityIndicatorContainer extends StatelessWidget {
  const ActivityIndicatorContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black.withOpacity(0.8)
            : Colors.white70,
        child: CupertinoActivityIndicator(
          color: Theme.of(context).colorScheme.onPrimary,
          radius: 32,
        ),
      ),
    );
  }
}