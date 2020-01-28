import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/models/order_model.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/order_widget.dart';
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  static const _orderDeviderIndent = 120.0;
  static const _checkoutButtonSize = Size(165.0, 46.0);
  static const _horizontalPagePadding = 20.0;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 20),
          child: Text(
            I18n.of(context).cartTitle,
            style: Styles.titleText,
          ),
        ),
        SizedBox(height: 29),
        Expanded(
          child: _buildOrderListView(),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(
              _horizontalPagePadding, 34, _horizontalPagePadding, 20.0),
          child: Divider(color: Palette.cartPageSecondaryText),
        ),
        _buildTotalOrderInformationWidget(),
      ],
    );
  }

  Widget _buildOrderListView() {
    return ListView.separated(
      padding:
          const EdgeInsets.fromLTRB(25.0, 29.0, _horizontalPagePadding, 0.0),
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
          padding: EdgeInsets.fromLTRB(0.0, 12, 0.0, 32.0),
          child: Divider(
            color: Palette.cartPageSecondaryText,
            indent: _orderDeviderIndent,
          ),
        );
      },
    );
  }

  Widget _buildTotalOrderInformationWidget() {
    var totalOrderCost = _orders.fold(
        0.0,
        (totalCost, nextOrder) =>
            (totalCost + nextOrder.count * nextOrder.cost));
    return Container(
      padding: EdgeInsets.fromLTRB(25.0, 0.0, _horizontalPagePadding, 15.0),
      width: Dimens.orderWidgetSize.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(_context).totalOrder,
                style: Styles.totalOrderText,
              ),
              SizedBox(height: 7.0),
              Text(
                Formatter.getCost(totalOrderCost),
                style: Styles.totalOrderCostText,
              ),
              SizedBox(height: 4.0),
              Text(
                I18n.of(_context).freeDomesticShipping,
                style: Styles.freeDomesticText,
              ),
            ],
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                height: _checkoutButtonSize.height,
                width: _checkoutButtonSize.width,
                child: PrimaryButtonWidget(
                  text: I18n.of(_context).checkoutButton,
                  onPressedFunction: () {},
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
