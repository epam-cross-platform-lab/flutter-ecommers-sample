import 'package:flutter/material.dart';

import '../index.dart';

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
      child: SurfaceContainer(
        child: widget.child,
      ),
    );
  }
}
