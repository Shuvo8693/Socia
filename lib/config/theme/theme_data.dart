import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData lightTheme() {
  return ThemeData(
      colorScheme: lightColorScheme,
      appBarTheme: AppBarTheme(surfaceTintColor: Colors.grey.shade600),
      iconTheme: IconThemeData(color: lightColorScheme.onPrimary),
      textSelectionTheme: TextSelectionThemeData(
          selectionHandleColor: Colors.blueAccent.shade100,
          selectionColor: Colors.blueAccent.shade100),
      inputDecorationTheme: InputDecorationTheme(
        border: buildOutlineInputBorder(),
        focusedBorder: buildOutlineInputBorder(),
        disabledBorder: buildOutlineInputBorder(),
        enabledBorder: buildOutlineInputBorder(),
      ),
      elevatedButtonTheme: const ElevatedButtonThemeData(
          style: ButtonStyle(
              backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
              foregroundColor: WidgetStatePropertyAll(Colors.white),
              textStyle: WidgetStatePropertyAll(
                  TextStyle(fontWeight: FontWeight.w700)),
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)))))),
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.primaryColor),
        overlayColor:
            WidgetStatePropertyAll(AppColors.primaryColor.withOpacity(0.2)),
        shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
      )),
      dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black)));
}

ThemeData darkTheme() {
  return ThemeData(
    colorScheme: darkColorScheme,
    appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade900),
    iconTheme: IconThemeData(color: darkColorScheme.onPrimary),
    inputDecorationTheme: InputDecorationTheme(
      border: buildOutlineInputBorder(),
      focusedBorder: buildOutlineInputBorder(),
      disabledBorder: buildOutlineInputBorder(),
      enabledBorder: buildOutlineInputBorder(),
    ),
    elevatedButtonTheme: const ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.primaryColor),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
            textStyle:
                WidgetStatePropertyAll(TextStyle(fontWeight: FontWeight.w700)),
            shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)))))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: const WidgetStatePropertyAll(AppColors.primaryColor),
      overlayColor:
          WidgetStatePropertyAll(AppColors.primaryColor.withOpacity(0.2)),
      shape: const WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)))),
    )),
    bottomNavigationBarTheme:
        BottomNavigationBarThemeData(backgroundColor: Colors.grey.shade900),
    dialogBackgroundColor: Colors.white,
    dialogTheme: const DialogTheme(
        surfaceTintColor: Colors.white,
        titleTextStyle: TextStyle(color: Colors.black)),
  );
}

ColorScheme lightColorScheme = ColorScheme.light(
    surface: Colors.white,
    brightness: Brightness.light,
    onPrimary: Colors.black,
    shadow: Colors.grey.shade500);

ColorScheme darkColorScheme = const ColorScheme.dark(
  brightness: Brightness.dark,
  surface: Colors.black54,
  onPrimary: Colors.white,
  shadow: Colors.white,
);

OutlineInputBorder buildOutlineInputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(
        width: 1, color: AppColors.textFieldBorderSideAndSenderBarColor));
