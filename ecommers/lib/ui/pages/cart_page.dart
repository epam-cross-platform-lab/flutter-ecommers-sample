import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const _orderDeviderIndent = 100.0;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Padding(
      padding:
          const EdgeInsets.fromLTRB(Insets.x6, Insets.x0, Insets.x5, Insets.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            I18n.of(context).cartTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          const SizedBox(height: 16),
          Expanded(
            child: _buildOrderListView(cartProvider),
          ),
          const Padding(
            padding:
                EdgeInsets.fromLTRB(Insets.x0, Insets.x4, Insets.x0, Insets.x2),
            child: Divider(color: BrandingColors.secondary),
          ),
          TotalOrderWidget(
            cost: cartProvider.calculateTotalCost(),
            backgroundColor: BrandingColors.pageBackground,
            onButtonPressedFunction: () =>
                navigationService.navigateTo(Pages.checkout),
            buttonText: I18n.of(context).checkoutButton,
          )
        ],
      ),
    );
  }

   Widget _buildOrderListView(CartProvider cartProvider) {
      return ListView.separated(
        padding: const EdgeInsets.fromLTRB(
            Insets.x0, Insets.x0, Insets.x5, Insets.x0),
        itemCount: cartProvider.orederCount,
        itemBuilder: (BuildContext context, int index) {
          final currentOrder = cartProvider.orders[index];
          return OrderWidget(
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
          return Padding(
            padding: const EdgeInsets.fromLTRB(
                Insets.x0, Insets.x3, Insets.x0, Insets.x4),
            child: Divider(
              color: BrandingColors.secondary.withOpacity(0.4),
              indent: _orderDeviderIndent,
            ),
          );
        },
      );
    }

}
