import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:flutter/material.dart';

class AuthorizationTabBase extends StatelessWidget {
  final List<Widget> children;

  AuthorizationTabBase({this.children});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, viewportConstraints) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: Dimens.pagePadding),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: children,
            ),
          ),
        ),
      );
    });
  }
}
