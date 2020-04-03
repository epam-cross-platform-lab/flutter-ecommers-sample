import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
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
import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final KeyboardVisibilityNotification keyboardVisibilityNotification =
      KeyboardVisibilityNotification();
  bool isTotalOrderVisible = true;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return CloseablePage(
      child: Column(
        children: <Widget>[
          Expanded(
            child: BackgroundedSafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                    Insets.x6, Insets.x0, Insets.x5, Insets.x4),
                child: _buildOrderListView(cartProvider),
              ),
            ),
          ),
          Visibility(
            visible: isTotalOrderVisible,
            child: TotalOrderWidget(
              cost: cartProvider.calculateTotalCost(),
              backgroundColor: BrandingColors.background,
              onButtonPressedFunction: () {
                navigationService.navigateTo(Pages.success);
                //todo request for place order
                cartProvider.resetCart();
              },
              

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

  Widget _buildOrderListView(CartProvider cartProvider) {
    final int newItemCount = cartProvider.orders.length + 2;
    return ListView.separated(
      itemCount: newItemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildListHeader();
        }

        if (index == newItemCount - 1) {
          return _buildListFooter();
        }

        final currentOrder = cartProvider.orders[index - 1];
        return SmallOrderWidget(
          primaryText: currentOrder.title,
          secondaryText: currentOrder.description,
          assetImagePath: currentOrder.imagePath,
          cost: currentOrder.cost,
          count: currentOrder.count,
          countIncrementFunction: () => cartProvider.addOrEdit(currentOrder),
          countDecrementFunction: () => cartProvider.removeOrEdit(currentOrder),
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
        CachedImage(imagePath: imagePath),
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
