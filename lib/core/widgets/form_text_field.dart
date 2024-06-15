import 'package:flutter/material.dart';
import 'package:socia/config/theme/app_color.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key,
    required this.controller,
    required this.prefixIcon,
    required this.hintText,
    this.suffixIcon,
    this.obscureText,
    this.validator,
    this.boxHeight,
    this.boxWidth,
    this.borderSideColor,
  });

  final TextEditingController controller;
final Icon prefixIcon;
final IconButton? suffixIcon;
final String hintText;
final bool? obscureText;
final String? Function(String?)? validator;
final double? boxHeight;
final double? boxWidth;
final Color? borderSideColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height:boxHeight?? 36,
      width: boxWidth?? 295,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4),
              borderSide:  const BorderSide(width: 1,color:  Color(0xFFF97066))),
          enabledBorder: buildOutlineInputBorder(),
          focusedBorder: buildOutlineInputBorder(),
          contentPadding: const EdgeInsets.all(3),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          errorMaxLines: 2,
          errorStyle: const TextStyle(fontSize: 10),
          hintStyle: const TextStyle(color: Colors.grey)
        ),
        obscureText: obscureText??false,
        validator: validator,
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(borderRadius: BorderRadius.circular(4),
            borderSide:   BorderSide(width: 1,color:  borderSideColor??AppColors.textFieldBorderSideAndSenderBarColor));
  }

}