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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(
            Assets.backIcon,
            color: BrandingColors.primary,
            height: Insets.x4_5,
          ),
          onPressed: () => navigationService.goBack(),
        ),
      ),
      body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: Insets.x2_5),
              ),
              Container(
                decoration: BoxDecoration(
                  color: BrandingColors.background,
                  borderRadius: BorderRadius.circular(Radiuses.normal),
                  boxShadow: const [
                    BoxShadow(
                      blurRadius: Radiuses.big_1x,
                      offset: Dimens.defaultBlurOffset,
                      color: BrandingColors.blur,
                    )
                  ],
                ),
                child: ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: listFilterParametrs.length,
                    padding: const EdgeInsets.all(0.0),
                    itemBuilder: (context, index) {
                      child:
                      Text(listFilterParametrs[index]);
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: BrandingColors.secondary.withOpacity(0.1),
                        height: 1.0,
                        endIndent: 17.0,
                        thickness: 1,
                      );
                    }),
              ),
            ],
          )
          //  ListView.separated(
          //         separatorBuilder: (context, index) => Divider(
          //           color: Colors.black,
          //         ),
          //         itemCount: listFilterParametrs.length,
          //         itemBuilder: (context, index) => Padding(
          //           padding: EdgeInsets.all(8.0),
          //           child:  MenuList(
          //                       title: 'MEN\'S APPAREL',
          //                       itemHeight: 44.0,
          //                       itemList: listFilterParametrs,
          //                     ),
          //         ),
          ),
    );
  }
}
