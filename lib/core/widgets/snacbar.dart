import 'package:flutter/material.dart';

void snackBarMessage(
    {required BuildContext context, required String title, bool? isColorRed}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(title),
    duration: const Duration(seconds: 3),
    backgroundColor: isColorRed == true
        ? Colors.redAccent.withOpacity(0.9)
        : Colors.green.withOpacity(0.9),
    shape: const OutlineInputBorder(
         borderSide: BorderSide.none,
        borderRadius: BorderRadius.only(
      topLeft: Radius.circular(8),
      topRight: Radius.circular(8),
    )),
  ));
}
