import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingActivityBar extends StatelessWidget {
  const LoadingActivityBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black54,
      body: Center(
        child: CupertinoActivityIndicator(
          color: Colors.white,
          radius: 28.0,
        ),
      ),
    );
  }
}
