import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData themeData() {
  return ThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        disabledBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
              foregroundColor: MaterialStatePropertyAll(Colors.white),
              textStyle: MaterialStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w700)),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)))))),

      // colorScheme: ColorScheme.fromSeed(seedColor: Colors.black54),
      colorSchemeSeed: Colors.white,
      textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
      )));
}

OutlineInputBorder buildOutlineInputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide:
        const BorderSide(width: 1, color: AppColors.textFieldBorderSideAndSenderBarColor));
