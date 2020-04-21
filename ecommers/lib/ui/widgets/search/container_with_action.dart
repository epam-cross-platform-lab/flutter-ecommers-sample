import 'package:flutter/material.dart';

import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';

class ContainerWithAction extends StatelessWidget {
  final String title;
  final String actionText;
  final void Function() action;
  final Widget child;

  const ContainerWithAction({
    Key key,
    this.title,
    this.actionText,
    this.action,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (child == null) return const SizedBox();

    return Column(
      children: [
        Row(
          children: <Widget>[
            Text(
              title,
              style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: FontSizes.small_3x,
                    color: Colors.transparent.withOpacity(0.3),
                  ),
            ),
            const Spacer(),
            InkWell(
              onTap: () => action(),
              child: Text(
                actionText,
                style: Theme.of(context).textTheme.headline5.copyWith(
                    fontSize: FontSizes.small_3x,
                    color: BrandingColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: Insets.x5),
        child,
      ],
    );
  }
}
