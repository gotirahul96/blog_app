import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final bool isObscureText;
  final TextEditingController? controller;
  final String validatorText;
  const AuthField({
    super.key,
    required this.hintText,
    this.isObscureText = false,
    this.controller,
    this.validatorText = 'This field is required'
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(hintText: hintText),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return validatorText;
        }
        return null;
      },
    );
  }
}
