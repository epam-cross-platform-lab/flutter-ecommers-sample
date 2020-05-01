import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/utils/index.dart';
import 'package:ecommers/ui/widgets/circle_icon.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool isTotalOrderVisible = true;
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    isTotalOrderVisible = MediaQuery.of(context).viewInsets.bottom == 0.0;

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
        Consumer<PaymentMethodProviderModel>(
          builder: (_, provider, __) {
            return _buildRowAction(
                imagePath: Assets.creditCard,
                text: Text(
                  Formatter.getTextWithNumberCard(
                          provider?.selectedPaymentMethod?.cardNumberLast4) ??
                      I18n.of(context).selectCreditCard,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(fontWeight: FontWeight.w700),
                ),
                action: () =>
                    navigationService.navigateTo(Pages.paymentMethod));
          },
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

  Widget _buildListFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDevider(),
        SizedBox(
          height: 28,
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: I18n.of(context).messageToSeller,
              hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                    fontWeight: FontWeight.w300,
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ),
        ),
        _buildDevider(),
        _buildRowAction(
          imagePath: Assets.sale,
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
          return _buildListFooter(context);
        }

        final currentOrder = cartProvider.orders[index - 1];
        return SmallOrderWidget(
          primaryText: currentOrder.product.title,
          secondaryText: currentOrder.characteristics,
          assetImagePath: currentOrder.product.previewImage,
          cost: currentOrder.product.price,
          count: currentOrder.count,
          countIncrementFunction: () => cartProvider.add(currentOrder),
          countDecrementFunction: () => cartProvider.remove(currentOrder),
          tapOrderFunction: () => navigationService.navigateTo(Pages.product,
              arguments: currentOrder.product),
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
    return InkWell(
      onTap: () => navigationService.navigateTo(Pages.shippingAddress),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Consumer<ShippingAddressProviderModel>(
                builder: (_, provider, __) {
              return _textBlockShippingAddress(provider, context);
            }),
          ),
          const CircleIcon(),
        ],
      ),
    );
  }

  Widget _textBlockShippingAddress(
      ShippingAddressProviderModel provider, BuildContext context) {
    if (provider?.selectedShippingAddress?.id == null) {
      return Text(
        'Select address',
        style: Theme.of(context)
            .textTheme
            .bodyText1
            .copyWith(fontWeight: FontWeight.w700),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          provider?.selectedShippingAddress?.fullName,
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          '${provider?.selectedShippingAddress?.country}, ${provider?.selectedShippingAddress?.city}, ${provider?.selectedShippingAddress?.state}',
          style: Theme.of(context)
              .textTheme
              .bodyText1
              .copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildRowAction({String imagePath, Text text, Function() action}) {
    return InkWell(
      onTap: action,
      child: Row(
        children: <Widget>[
          SvgPicture.asset(
            imagePath,
          ),
          const SizedBox(width: Insets.x3_5),
          text,
          const Spacer(),
          const CircleIcon(),
        ],
      ),
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
