import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/models/page_arguments.dart';
import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
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
  CartProvider _cartProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _cartProvider = Provider.of<CartProvider>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.fromLTRB(Insets.x0, Insets.x0, Insets.x0, Insets.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
              child: Text(localization.cartTitle,
                  style: textTheme.headline6)),
          const SizedBox(height: 16),
          Expanded(child: _buildOrderListView()),
          const Padding(
              padding: EdgeInsets.fromLTRB(
                  Insets.x0, Insets.x4, Insets.x0, Insets.x2),
              child: Divider(color: BrandingColors.secondary)),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: Insets.x4),
              child: TotalOrderWidget(
                cost: _cartProvider.calculateTotalCost(),
                backgroundColor: BrandingColors.pageBackground,
                onButtonPressedFunction: () =>
                    navigationService.navigateTo(Pages.checkout),
                buttonText: localization.checkoutButton,
                isButtonDisabled: _cartProvider.orderCount == 0,
              ))
        ],
      ),
    );
  }

  Widget _buildOrderListView() {
    return ListView.separated(
      itemCount: _cartProvider.orderCount,
      itemBuilder: (BuildContext context, int index) {
        final currentOrder = _cartProvider.orders[index];
        final key = GlobalKey<SlideMenuState>();
        return SlideMenu(
            key: key,
            dismissed: () =>
                _cartProvider.remove(currentOrder, count: currentOrder.count),
            dismissItem: _createRemoveWidget(currentOrder,
                alignment: Alignment.centerLeft),
            menuItems: [_createRemoveWidget(currentOrder)],
            child: OrderWidget(
              primaryText: currentOrder.product.title,
              secondaryText: currentOrder.characteristics,
              assetImagePath: currentOrder.product.previewImage,
              cost: currentOrder.product.price,
              count: currentOrder.count,
              tapOrderFunction: () => navigationService.navigateTo(
                Pages.product,
                arguments: PageArguments(
                  arg1: currentOrder.product,
                  arg2: false,
                ),
              ),
              countIncrementFunction: () => _cartProvider.add(currentOrder),
              countDecrementFunction: () => _handleRemove(key, currentOrder),
            ));
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

  void _handleRemove(GlobalKey<SlideMenuState> key, OrderModel order) {
    if (order.count == 1) {
      key.currentState.openMenu();
    } else {
      _cartProvider.remove(order);
    }
  }

  Widget _createRemoveWidget(OrderModel order,
      {Alignment alignment = Alignment.center}) {
    return Container(
        alignment: Alignment.center,
        color: BrandingColors.primary,
        child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => _cartProvider.remove(order, count: order.count)));
  }
}
