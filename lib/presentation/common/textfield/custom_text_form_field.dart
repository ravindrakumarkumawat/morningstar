import 'package:flutter/material.dart';
import 'package:morningstar/presentation/constants/outline_input_border.dart';
import 'package:morningstar/presentation/theme/theme.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    this.fieldKey,
    required this.controller,
    required this.labelText,
    this.hintText,
    this.keyboardType,
    this.labelStyle,
    this.validator,
    this.obscureText = false,
    this.error,
    this.errorText,
    this.errorStyle,
    this.suffixIcon,
  });
  final Key? fieldKey;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final TextStyle? labelStyle;
  final String? Function(String?)? validator;

  final bool obscureText;
  final String labelText;
  final String? hintText;
  final Widget? error;
  final String? errorText;
  final TextStyle? errorStyle;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: fieldKey,
      obscureText: obscureText,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: labelStyle?.copyWith(color: Pallete.blackColor) ??
            const TextStyle(color: Pallete.blackColor),
        error: error,
        errorText: errorText,
        errorStyle: errorStyle?.copyWith(color: Pallete.redColor) ??
            const TextStyle(color: Pallete.redColor),
        border: BorderState.border,
        enabledBorder: BorderState.enabledBorder,
        focusedBorder: BorderState.focusedBorder,
        errorBorder: BorderState.errorBorder,
        focusedErrorBorder: BorderState.focusedErrorBorder,
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
