import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/models/order_model.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/utils/formatter.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/order_widget.dart';
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
          padding: EdgeInsets.only(left: Insets.x5),
          child: Text(
            I18n.of(context).cartTitle,
            style: Theme.of(context).textTheme.title,
          ),
        ),
        SizedBox(height: 29),
        Expanded(
          child: _buildOrderListView(),
        ),
        Padding(
          padding:
              EdgeInsets.fromLTRB(Insets.x5, Insets.x8_5, Insets.x5, Insets.x5),
          child: Divider(color: BrandingColors.secondary),
        ),
        _buildTotalOrderInformationWidget(),
      ],
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
          padding:
              EdgeInsets.fromLTRB(Insets.x0, Insets.x3, Insets.x0, Insets.x8),
          child: Divider(
            color: BrandingColors.secondary,
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
      padding: EdgeInsets.fromLTRB(Insets.x6, Insets.x0, Insets.x5, Insets.x4),
      width: CartPage.orderWidgetSize.width,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                I18n.of(_context).totalOrder,
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontSize: FontSizes.small_1x),
              ),
              SizedBox(height: 7.0),
              Text(
                Formatter.getCost(totalOrderCost),
                style: Theme.of(context)
                    .textTheme
                    .title
                    .copyWith(fontSize: 20.0), //TODO: check 20.0
              ),
              SizedBox(height: 4.0),
              Text(
                I18n.of(_context).freeDomesticShipping,
                style: Theme.of(context)
                    .textTheme
                    .subtitle
                    .copyWith(fontWeight: FontWeight.w400),
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
