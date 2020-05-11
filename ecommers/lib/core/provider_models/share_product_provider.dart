import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:flutter/material.dart';

class ShareProductProviderModel extends ChangeNotifier {
  Future shareDynamicLink(Product product) async {
    await shareProductService.shareeDynamicLinkText(product);
  }

  Future shareImage(Product product) async {
    await shareProductService.shareImage(product);
  }

  Future shareText(Product product) async {
    await shareProductService.shareText(product);
  }

  Future shareTextImage(Product product) async {
    await shareProductService.shareImageWithText(product);
  }
}
