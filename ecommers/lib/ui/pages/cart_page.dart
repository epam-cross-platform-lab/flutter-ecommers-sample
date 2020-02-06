import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/models/order_model.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/checkout_page.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  static const orderWidgetSize = Size(272.0, 102.0);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const _orderDeviderIndent = 120.0;
  static const _checkoutButtonSize = Size(165.0, 46.0);

  BuildContext _context;
  final _orders = List.generate(
    20,
    (index) => OrderModel(
        title: 'Bottle Green Backpack',
        description: 'Medium, Green',
        cost: 2.58,
        imagePath: GREEN_BACKPACK_IMAGE,
        count: 1),
  );

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
            style: Theme.of(context).textTheme.title,
          ),
          SizedBox(height: 29),
          Expanded(
            child: _buildOrderListView(),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(0, 34, 0, 20.0),
            child: Divider(color: BrandingColors.secondary),
          ),
          TotalOrderWidget(
            cost: totalOrderCost,
            backgroundColor: BrandingColors.pageBackground,
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

      padding:
          const EdgeInsets.fromLTRB(Insets.x6, Insets.x7, Insets.x5, Insets.x0),
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

          padding: const EdgeInsets.fromLTRB(
              Insets.x0, Insets.x3, Insets.x0, Insets.x8),
          child: const Divider(
            color: BrandingColors.secondary,
            indent: _orderDeviderIndent,
          ),
        );
      },
    );
  }
}
