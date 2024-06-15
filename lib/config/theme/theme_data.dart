import 'package:flutter/material.dart';

import 'app_color.dart';

ThemeData lightTheme() {
  return ThemeData(
      colorScheme: lightColorScheme,
      appBarTheme: AppBarTheme(
        surfaceTintColor: Colors.grey.shade400,
      ),
      iconTheme: IconThemeData(color: lightColorScheme.onPrimary),
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
      textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
        foregroundColor: const MaterialStatePropertyAll(AppColors.primaryColor),
        overlayColor:
            MaterialStatePropertyAll(AppColors.primaryColor.withOpacity(0.2)),
        shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)))),
      )),
      dialogTheme: const DialogTheme(
          surfaceTintColor: Colors.white,
          titleTextStyle: TextStyle(color: Colors.black)),
    bottomSheetTheme: const BottomSheetThemeData(surfaceTintColor: Colors.white)
  );

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
            backgroundColor: MaterialStatePropertyAll(AppColors.primaryColor),
            foregroundColor: MaterialStatePropertyAll(Colors.white),
            textStyle: MaterialStatePropertyAll(
                TextStyle(fontWeight: FontWeight.w700)),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)))))),
    textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
      foregroundColor: const MaterialStatePropertyAll(AppColors.primaryColor),
      overlayColor:
          MaterialStatePropertyAll(AppColors.primaryColor.withOpacity(0.2)),
      shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
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
    background: Colors.white,
    brightness: Brightness.light,
    onPrimary: Colors.black,
    shadow: Colors.grey.shade500);

ColorScheme darkColorScheme = const ColorScheme.dark(
  brightness: Brightness.dark,
  background: Colors.black54,
  onPrimary: Colors.white,
  shadow: Colors.white,
);

OutlineInputBorder buildOutlineInputBorder() => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4),
    borderSide: const BorderSide(
        width: 1, color: AppColors.textFieldBorderSideAndSenderBarColor));
