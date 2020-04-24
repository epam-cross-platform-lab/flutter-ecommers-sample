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

  const CreditCardTextField({
    this.hintText = '',
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onValidate,
    this.onChanged,
    this.width,
    this.maxLength = 26, 
    this.inputFormatters,
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
            counterText: '',
            counterStyle: const TextStyle(fontSize: 0),
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: FontSizes.small_3x,
                color: BrandingColors.primaryText.withOpacity(0.5)),
          ),
        ),
      ),
    );
  }
}
