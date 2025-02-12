import 'package:flutter/material.dart';

class CommonFormField extends StatelessWidget {
  const CommonFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.maxLine,
    this.validator,
  });

  final TextEditingController controller;
  final String hintText;
  final int? maxLine;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine ?? 2,
      keyboardType: TextInputType.text,
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade400),
        border: buildOutlineInputBorderSideNone(),
        focusedBorder: buildOutlineInputBorderSideNone(),
        enabledBorder: buildOutlineInputBorderSideNone(),
        disabledBorder: buildOutlineInputBorderSideNone(),
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorderSideNone() =>
      const OutlineInputBorder(borderSide: BorderSide.none);
}
