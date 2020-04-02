import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const _orderDeviderIndent = 100.0;

  static String _getDressAssetPath(int index) {
    final modulo = index % 17;

    if (modulo == 0) return Assets.dressCottonImage;
    if (modulo == 1) return Assets.dressFloral2Image;
    if (modulo == 2) return Assets.dressFloralImage;
    if (modulo == 3) return Assets.dressPattern2Image;
    if (modulo == 4) return Assets.dressPatternImage;
    if (modulo == 5) return Assets.blackShoes;
    if (modulo == 6) return Assets.goldShoes;
    if (modulo == 7) return Assets.redShoes;
    if (modulo == 8) return Assets.roseRedShoes;
    if (modulo == 9) return Assets.silverShoes;
    if (modulo == 10) return Assets.pinkShoes;
    if (modulo == 11) return Assets.shirtImage;
    if (modulo == 12) return Assets.yellowShoes;
    if (modulo == 13) return Assets.whiteShoes;
    if (modulo == 14) return Assets.backpackImage;     
    if (modulo == 15) {
      return Assets.dressCotton2Image;
    } else {
      return Assets.greenBackpackImage;
    }
  }

  BuildContext _context;
  final _orders = List.generate(
    17,
    (index) => OrderModel(
        title: 'Bottle Green Backpack',
        description: 'Medium, Green',
        cost: 2.58,
        imagePath: _getDressAssetPath(index),
        count: 1),
  );

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

  @override
  Widget build(BuildContext context) {
    _context = context;
    final double totalOrderCost = _orders.fold(0.0,
        (totalCost, nextOrder) => totalCost + nextOrder.count * nextOrder.cost);

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
            child: _buildOrderListView(),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(
                Insets.x0, Insets.x4, Insets.x0, Insets.x2),
            child: Divider(color: BrandingColors.secondary),
          ),
          TotalOrderWidget(
            cost: totalOrderCost,
            backgroundColor: BrandingColors.pageBackground,
            onButtonPressedFunction: () =>
                navigationService.navigateTo(Pages.checkout),
            buttonText: I18n.of(_context).checkoutButton,
          )
        ],
      ),
    );
  }

  Widget _buildOrderListView() {
    return ListView.separated(
      padding:
          const EdgeInsets.fromLTRB(Insets.x0, Insets.x0, Insets.x5, Insets.x0),
      itemCount: _orders.length,
      itemBuilder: (BuildContext context, int index) {
        final currentOrder = _orders[index];
        return OrderWidget(
          primaryText: currentOrder.title,
          secondaryText: currentOrder.description,
          assetImagePath: currentOrder.imagePath,
          cost: currentOrder.cost,
          count: currentOrder.count,
          countIncrementFunction: () => incrementCount(currentOrder),
          countDecrementFunction: () => decrementCount(currentOrder),
          tapOrderFunction:() => navigationService.navigateTo(Pages.product),
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
