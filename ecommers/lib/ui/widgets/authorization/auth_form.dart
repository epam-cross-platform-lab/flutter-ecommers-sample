import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final Widget child;

  AuthForm({this.child});

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Radiuses.normal),
          color: BrandingColors.background,
          boxShadow: const <BoxShadow>[
            BoxShadow(
              offset: Dimens.defaultBlurOffset,
              blurRadius: Radiuses.big_1x,
              color: BrandingColors.blur,
            )
          ],
        ),
        child: widget.child,
      ),
    );
  }
}
