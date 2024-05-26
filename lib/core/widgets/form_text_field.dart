import 'package:flutter/material.dart';

class FormTextField extends StatelessWidget {
  const FormTextField({
    super.key, required this.controller,
    required this.prefixIcon,
    required this.hintText,
    required this.suffixIcon,
    required this.obscureText, required this.validator,
  });

final TextEditingController controller;
final Icon prefixIcon;
final IconButton? suffixIcon;
final String hintText;
final bool obscureText;
final String? Function(String?) validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      width: 295,
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4),
              borderSide: const BorderSide(width: 1,color: Color(0xFFF97066))),
          contentPadding: const EdgeInsets.all(3),
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.grey)
        ),
        obscureText: obscureText,
        validator: validator,
      ),
    );
  }

}