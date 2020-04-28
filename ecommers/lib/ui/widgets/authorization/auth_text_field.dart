import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AuthTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String svgIconPath;
  final String prefixText;
  final IconData icon;
  final TextInputType keyboardType;
  final bool obscureText;
  final String Function(String) onValidate;
  final Function(String) onChanged;

  const AuthTextField(
      {this.labelText = '',
      this.svgIconPath = '',
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.controller,
      this.onValidate,
      this.prefixText,
      this.onChanged,
      this.icon});

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
        prefixText: prefixText,
        labelStyle: Theme.of(context).textTheme.headline5,
        prefixIcon: _buildIcon(),
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

  Widget _buildIcon() {
    if (svgIconPath.isNotEmpty) {
      return SvgPicture.asset(
        svgIconPath,
        fit: BoxFit.scaleDown,
      );
    }

    if (icon != null) {
      return Icon(icon);
    }

    return null;
  }
}
