import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/widgets/circle_icon.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final KeyboardVisibilityNotification keyboardVisibilityNotification =
      KeyboardVisibilityNotification();
  bool isTotalOrderVisible = true;

  @override
  void initState() {
    super.initState();

    keyboardVisibilityNotification.addNewListener(
      onChange: (bool visible) {
        setState(() {
          isTotalOrderVisible = !visible;
        });
      },
    );
  }

  @override
  void dispose() {
    keyboardVisibilityNotification.dispose();
    super.dispose();
  }

  static const int _itemCount = 20;

  static String _getDressAssetPath(int index) {
    final modulo = index % 7;

    if (modulo == 0) return Assets.dressCottonImage;
    if (modulo == 1) return Assets.dressFloral2Image;
    if (modulo == 2) return Assets.dressFloralImage;
    if (modulo == 3) return Assets.dressPattern2Image;
    if (modulo == 4) return Assets.dressPatternImage;
    if (modulo == 5) return Assets.dressCotton2Image;
    if (modulo == 6) {
      return Assets.greenBackpackImage;
    } else {
      return Assets.greenBackpackImage;
    }
  }

  final _orders = List.generate(
      _itemCount,
      (index) => OrderModel(
          title: 'Bottle Green Backpack',
          description: 'Medium, Green',
          cost: 2.58,
          imagePath: _getDressAssetPath(index),
          count: 1));

  @override
  Widget build(BuildContext context) {
    final double totalOrderCost = _orders.fold(0.0,
        (totalCost, nextOrder) => totalCost + nextOrder.count * nextOrder.cost);

    return CloseablePage(
      child: Column(
        children: <Widget>[
          Expanded(
            child: BackgroundedSafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    Insets.x6, Insets.x0, Insets.x5, Insets.x4),
                child: _buildOrderListView(),
              ),
            ),
          ),
          Visibility(
            visible: isTotalOrderVisible,
            child: TotalOrderWidget(
              cost: totalOrderCost,
              backgroundColor: BrandingColors.background,
              onButtonPressedFunction: () =>
                  navigationService.navigateTo(Pages.success),
              buttonText: I18n.of(context).placeOrderButton,
              padding: const EdgeInsets.fromLTRB(
                  Insets.x6, Insets.x2, Insets.x5, Insets.x3_5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          I18n.of(context).checkoutTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
        Text(
          I18n.of(context).shippingAddress,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: Insets.x2),
        _buildShippingAddress(),
        _buildDevider(),
        Text(
          I18n.of(context).paymentMethod,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: Insets.x2),
        _buildRowAction(
          imagePath: Assets.creditCardImage,
          text: Text(
            I18n.of(context).cardEnding,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        _buildDevider(),
        Text(
          I18n.of(context).items,
          style: Theme.of(context).textTheme.headline5,
        ),
        const SizedBox(height: 14.0),
      ],
    );
  }

  Widget _buildListFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDevider(),
        SizedBox(
          height: 28,
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Message to seller (optional)',
              hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ),
        _buildDevider(),
        _buildRowAction(
          imagePath: Assets.saleImage,
          text: Text(
            I18n.of(context).addPromoCode,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(color: BrandingColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderListView() {
    final int newItemCount = _orders.length + 2;
    return ListView.separated(
      itemCount: newItemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildListHeader();
        }

        if (index == newItemCount - 1) {
          return _buildListFooter();
        }

        final currentOrder = _orders[index - 1];
        return SmallOrderWidget(
          primaryText: currentOrder.title,
          secondaryText: currentOrder.description,
          assetImagePath: currentOrder.imagePath,
          cost: currentOrder.cost,
          count: currentOrder.count,
          countIncrementFunction: () => incrementCount(currentOrder),
          countDecrementFunction: () => decrementCount(currentOrder),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const SizedBox(height: 0);
        }
        if (index == newItemCount - 2) {
          return const SizedBox(height: 0);
        }
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              Insets.x0, Insets.x3, Insets.x0, Insets.x4),
          child: Divider(
            color: BrandingColors.secondary.withOpacity(0.4),
            indent: 83.0,
          ),
        );
      },
    );
  }

  void decrementCount(OrderModel order) {
    if (order.count == 1) _orders.remove(order);

    setState(() {
      order.count--;
    });
  }

  void incrementCount(OrderModel order) {
    setState(() {
      order.count++;
    });
  }

  Widget _buildShippingAddress() {
    return Row(
      children: <Widget>[
        Container(
          width: 136,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'John Doe', //TODO from provider
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'No 123, Sub Street, Main Street,City Name, Province, Country',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        const Spacer(),
        const CircleIcon(),
      ],
    );
  }

  Widget _buildRowAction({String imagePath, Text text}) {
    return Row(
      children: <Widget>[
        CachedNetworkImage(
          imageUrl:
              'https://raw.githubusercontent.com/epam-cross-platform-lab/flutter-ecommers-sample/dev/design_sources/$imagePath',
          errorWidget: (context, url, error) =>
              SvgPicture.asset(Assets.warningIcon),
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: Insets.x3_5),
        text,
        const Spacer(),
        const CircleIcon(),
      ],
    );
  }

  Widget _buildDevider() {
    return Divider(
      color: BrandingColors.secondary.withOpacity(0.15),
      thickness: 1.0,
      height: 24.0,
    );
  }
}
