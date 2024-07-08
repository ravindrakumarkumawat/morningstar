import 'package:flutter/material.dart';
import 'package:morningstar/constants/outline_input_border.dart';
import 'package:morningstar/theme/pallete.dart';

class PasswordField extends StatefulWidget {
  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final TextEditingController _passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _passwordController,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter your password',
        labelStyle: const TextStyle(
          color: Pallete.blackColor,
        ),
        // hintText: 'Email, Phone, or Username',
        border: BorderState.border,
        enabledBorder: BorderState.enabledBorder,
        focusedBorder: BorderState.focusedBorder,
        errorBorder: BorderState.errorBorder,
        focusedErrorBorder: BorderState.focusedErrorBorder,
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        ),
      ),
    );
  }
}
