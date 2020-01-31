import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/models/order_model.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/checkout_page.dart';
import 'package:ecommers/ui/widgets/order_widget.dart';
import 'package:ecommers/ui/widgets/total_order_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const _orderDeviderIndent = 120.0;

  BuildContext _context;
  final _orders = List.generate(20, (index) {
    return OrderModel(
        title: 'Bottle Green Backpack',
        description: 'Medium, Green',
        cost: 2.58,
        imagePath: GREEN_BACKPACK_IMAGE,
        count: 1);
  });
  @override
  Widget build(BuildContext context) {
    _context = context;
    var totalOrderCost = _orders.fold(
        0.0,
        (totalCost, nextOrder) =>
            (totalCost + nextOrder.count * nextOrder.cost));

    return Padding(
      padding: EdgeInsets.fromLTRB(25, 0, 20, 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            I18n.of(context).cartTitle,
            style: Styles.titleText,
          ),
          SizedBox(height: 29),
          Expanded(
            child: _buildOrderListView(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 34, 0, 20.0),
            child: Divider(color: Palette.cartPageSecondaryText),
          ),
          TotalOrderWidget(
            cost: totalOrderCost,
            backgroundColor: Palette.pageBackground,
            onButtonPressedFunction: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CheckoutPage()),
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
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return OrderWidget(
          primaryText: _orders[index].title,
          secondaryText: _orders[index].description,
          assetImagePath: _orders[index].imagePath,
          cost: _orders[index].cost,
          count: _orders[index].count,
          countIncrementFunction: () {},
          countDecrementFunction: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.fromLTRB(0.0, 18, 0.0, 20.0),
          child: Divider(
            color: Palette.cartPageSecondaryText,
            indent: _orderDeviderIndent,
          ),
        );
      },
    );
  }
}
