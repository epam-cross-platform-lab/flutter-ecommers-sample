import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String assetIconPath;
  final TextInputType keyboardType;
  final bool obscureText;
  final String Function(String) onValidate;
  final Function(String) onChanged;

  const AuthTextField({
    this.labelText = '',
    this.assetIconPath = '',
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.controller,
    this.onValidate,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      onChanged: onChanged,
      validator: onValidate,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: Theme.of(context).textTheme.headline5,
        prefixIcon: SvgPicture.asset(
          assetIconPath,
          fit: BoxFit.scaleDown,
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        fillColor: Colors.transparent,
        filled: true,
      ),
    );
  }
}
