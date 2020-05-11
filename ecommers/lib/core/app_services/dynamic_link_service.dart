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
      print('Link Failed: ${e.message}');
    });
  }

  void _handleDeepLink(PendingDynamicLinkData data) {
    final Uri deepLink = data?.link;
    //int productId= deepLink?.

    if (deepLink != null) {
      print('_handleDeepLink | deeplink: $deepLink');
      var params = deepLink.queryParameters['params'];
      if (params != null) {
        navigationService.navigateTo(Pages.paymentMethod);
      }
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
      itunesConnectAnalyticsParameters: ItunesConnectAnalyticsParameters(
      ),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: '${product.details.brand} ${Formatter.getCost(product?.price)}',
        description: 'best store in the world',
      ),
    );

    final Uri dynamicUrl = await parameters.buildUrl();
    //final Uri dynamicUrl1 = parameters.link;

    return dynamicUrl.toString();
  }
}
