import 'dart:io';
import 'dart:typed_data';

import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/utils/index.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';

class ShareProductService {
  Future shareDynamicLinkText(Product product) async {
    try {
      final String dynamicLink =
          await dynamicLinkService.createDynamicLink(product);
      Share.text('${product.title}', '$dynamicLink', 'text/plain');
    } catch (ex) {
      logger.ex(ex);
    }
  }

  Future shareImageWithText(Product product) async {
    try {
      final request =
          await HttpClient().getUrl(Uri.parse(product?.previewImage));
      final response = await request.close();
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      await Share.file('${product.title}', '${product.title}.png', bytes, '*/*',
          text: Formatter.getShareText(product));
    } catch (ex) {
      logger.ex(ex);
    }
  }

  Future shareImage(Product product) async {
    try {
      final request =
          await HttpClient().getUrl(Uri.parse(product?.previewImage));
      final response = await request.close();
      final Uint8List bytes =
          await consolidateHttpClientResponseBytes(response);
      await Share.file(
          '${product.title}', '${product.title}.png', bytes, 'image/png');
    } catch (ex) {
      logger.ex(ex);
    }
  }

  Future shareText(Product product) async {
    try {
      Share.text(
          '${product.title}', Formatter.getShareText(product), 'text/plain');
    } catch (ex) {
      logger.ex(ex);
    }
  }
}
