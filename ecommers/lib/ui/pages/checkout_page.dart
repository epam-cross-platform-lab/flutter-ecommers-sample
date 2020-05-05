import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
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

  CartProvider _cartProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = Provider.of<CartProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    isTotalOrderVisible = MediaQuery.of(context).viewInsets.bottom == 0.0;

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
              cost: _cartProvider.calculateTotalCost(),
              backgroundColor: BrandingColors.background,
              onButtonPressedFunction: () {
                navigationService.navigateTo(Pages.success);
                //todo request for place order
                _cartProvider.resetCart();
              },
              buttonText: localization.placeOrderButton,
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
          localization.checkoutTitle,
          style: textTheme.headline6,
        ),
        const SizedBox(height: 20),
        Text(
          localization.shippingAddress,
          style: textTheme.headline5,
        ),
        const SizedBox(height: Insets.x2),
        _buildShippingAddress(),
        _buildDevider(),
        Text(
          localization.paymentMethod,
          style: textTheme.headline5,
        ),
        const SizedBox(height: Insets.x2),
        Consumer<PaymentMethodProviderModel>(
          builder: (_, provider, __) {
            return _buildRowAction(
                imagePath: Assets.creditCard,
                text: Text(
                  Formatter.getTextWithNumberCard(
                          provider?.selectedPaymentMethod?.cardNumberLast4) ??
                      localization.selectCreditCard,
                  style:
                      textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
                ),
                action: () =>
                    navigationService.navigateTo(Pages.paymentMethod));
          },
        ),
        _buildDevider(),
        Text(
          localization.items,
          style: textTheme.headline5,
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
              hintText:  localization.messageToSeller,
              hintStyle: textTheme.bodyText1.copyWith(
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
            localization.addPromoCode,
            style: textTheme
                .bodyText1
                .copyWith(color: BrandingColors.primary),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderListView() {
    final int newItemCount = _cartProvider.orders.length + 2;
    return ListView.separated(
      itemCount: newItemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildListHeader();
        }

        if (index == newItemCount - 1) {
          return _buildListFooter();
        }

        final currentOrder = _cartProvider.orders[index - 1];
        return SmallOrderWidget(
          primaryText: currentOrder.product.title,
          secondaryText: currentOrder.characteristics,
          assetImagePath: currentOrder.product.previewImage,
          cost: currentOrder.product.price,
          count: currentOrder.count,
          tapOrderFunction: () => navigationService.navigateTo(Pages.product, arguments: currentOrder.product),
          countIncrementFunction: () => _cartProvider.add(currentOrder),
          countDecrementFunction: () => _cartProvider.remove(currentOrder),
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
                style: textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'No 123, Sub Street, Main Street,City Name, Province, Country',
                style: textTheme
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
