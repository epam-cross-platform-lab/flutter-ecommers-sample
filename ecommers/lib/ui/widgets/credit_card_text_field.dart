import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CreditCardTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final String Function(String) onValidate;
  final Function(String) onChanged;
  final double width;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final bool isValid;

  const CreditCardTextField({
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.width,
    this.maxLength = 26,
    this.inputFormatters,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return SurfaceContainer(
      height: 46.0,
      width: width,
      child: Center(
        child: TextFormField(
          textAlign: TextAlign.center,
          controller: controller,
          inputFormatters: inputFormatters,
          keyboardType: keyboardType,
          onChanged: onChanged,
          validator: onValidate,
          maxLength: maxLength,
          maxLengthEnforced: true,
          decoration: InputDecoration(
            hoverColor: Colors.red,
            counterText: '',
            counterStyle: const TextStyle(fontSize: 0),
            focusedBorder: isValid ?? true
                ? InputBorder.none
                : const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.black38),
                  ),
            enabledBorder: isValid ?? true
                ? InputBorder.none : const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            hintText: hintText,
            hintStyle: textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: FontSizes.small_3x,
                color: BrandingColors.primaryText.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
