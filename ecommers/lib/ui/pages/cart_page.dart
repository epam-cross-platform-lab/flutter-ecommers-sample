import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/checkout_page.dart';
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
    var modulo = index % 7;

    if (modulo == 0) return DRESS_COTTON_IMAGE;
    if (modulo == 1) return DRESS_FLORAL2_IMAGE;
    if (modulo == 2) return DRESS_FLORAL_IMAGE;
    if (modulo == 3) return DRESS_PATTERN2_IMAGE;
    if (modulo == 4) return DRESS_PATTERN_IMAGE;
    if (modulo == 5) return DRESS_COTTON2_IMAGE;
    if (modulo == 6) return GREEN_BACKPACK_IMAGE;
    else{
      return GREEN_BACKPACK_IMAGE;
    }
  }
  BuildContext _context;
  final _orders = List.generate(
    20,
    (index) => OrderModel(
        title: 'Bottle Green Backpack',
        description: 'Medium, Green',
        cost: 2.58,
        imagePath: _getDressAssetPath(index),
        count: 1),
  );

  void decrementCount(order) {
    if (order.count == 1) _orders.remove(order);

    setState(() {
      order.count--;
    });

  }

  void incrementCount(order) {
    setState(() {
      order.count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    _context = context;
    var totalOrderCost = _orders.fold(
        0.0,
        (totalCost, nextOrder) =>
            (totalCost + nextOrder.count * nextOrder.cost));

    return Padding(
      padding: EdgeInsets.fromLTRB(Insets.x6, Insets.x0, Insets.x5, Insets.x4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            I18n.of(context).cartTitle,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox(height: 16),
          Expanded(
            child: _buildOrderListView(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(Insets.x0, Insets.x4, Insets.x0, Insets.x2),
            child: Divider(color: BrandingColors.secondary),
          ),
          TotalOrderWidget(
            cost: totalOrderCost,
            backgroundColor: BrandingColors.pageBackground,
            onButtonPressedFunction: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => CheckoutPage()),
              );
            },
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
        return OrderWidget(
          primaryText: _orders[index].title,
          secondaryText: _orders[index].description,
          assetImagePath: _orders[index].imagePath,
          cost: _orders[index].cost,
          count: _orders[index].count,
          countIncrementFunction: () => incrementCount(_orders[index]),
          countDecrementFunction: () => decrementCount(_orders[index]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(
              Insets.x0, Insets.x3, Insets.x0, Insets.x4),
          child:  Divider(
            color: BrandingColors.secondary.withOpacity(0.4),
            indent: _orderDeviderIndent,
          ),
        );
      },
    );
  }

}
