import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class RightMenuSecondPage extends StatelessWidget {
  final List<String> listFilterParametrs;

  const RightMenuSecondPage({this.listFilterParametrs});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 270,
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: SvgPicture.asset(
                Assets.backIcon,
                color: BrandingColors.primary,
                height: Insets.x4_5,
              ),
              onPressed: () => rightMenuNavigationService.goBack(),
            ),
          ),
          body: _myListView(context),
        ),
      ),
    );
  }

  Widget _myListView(BuildContext context) {
    return ListView.builder(
      itemCount: listFilterParametrs.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            rightMenuNavigationService.goBack();
          },
          child: ListTile(
            title: Text(listFilterParametrs[index]),
          ),
        );
      },
    );
  }
}
