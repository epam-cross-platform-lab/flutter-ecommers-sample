import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/page_base.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageBase(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            IconWithBadge(
              badgeValue: 6,
              icon: SvgPicture.asset(MESSAGES_IMAGE),
            ),
          ],
        ),
      ),
    );
  }
}
