import 'package:ecommers/core/models/data_models/index.dart';
import 'package:ecommers/ui/utils/index.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/core/common/index.dart';

class DynamicLinkService {
  Future handleDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();

    _handleDeepLink(data);

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      _handleDeepLink(dynamicLink);
    }, onError: (OnLinkErrorException e) async {
      logger.ex(e);
    });
  }

  Future _handleDeepLink(PendingDynamicLinkData data) async {
    final Uri deepLink = data?.link;

    if (deepLink != null && membershipService.isNotExpired) {
      final productId = int.parse(deepLink.queryParameters['id']);
      final Product product = await productService.fetchProductById(productId);
      navigationService.navigateTo(Pages.product, arguments: product);
    }
  }

  Future<String> createDynamicLink(Product product) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://ecommers.page.link',
      link: Uri.parse('https://ecommers.page.link/product-id?id=${product.id}'),
      androidParameters: AndroidParameters(
        packageName: 'com.ecommers.sample',
      ),
      iosParameters: IosParameters(
        bundleId: 'com.ecommers.sample',
      ),
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: '${product.details.brand} ${Formatter.getCost(product?.price)}',
        description: localization.e_commerce
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    return dynamicUrl.toString();
  }
}
