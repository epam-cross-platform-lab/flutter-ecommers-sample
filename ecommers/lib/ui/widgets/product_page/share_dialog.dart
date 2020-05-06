import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ShareDialog extends StatelessWidget {
  final Product productModel;

  const ShareDialog(this.productModel);

  @override
  Widget build(BuildContext context) {
    final shareProvider =
        Provider.of<ShareProductProviderModel>(context, listen: false);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Container(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title:
                    Text(localization.share_image, style: textTheme.bodyText1),
                onTap: () {
                  shareProvider.shareImage(productModel);
                },
              ),
              ListTile(
                title:
                    Text(localization.share_text, style: textTheme.bodyText1),
                onTap: () {
                  shareProvider.shareText(productModel);
                },
              ),
              ListTile(
                title: Text(localization.share_image_with_text,
                    style: textTheme.bodyText1),
                onTap: () {
                  shareProvider.shareTextImage(productModel);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
