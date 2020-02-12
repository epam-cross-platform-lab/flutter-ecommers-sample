import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/pages/succes_page.dart';
import 'package:ecommers/ui/widgets/circle_icon.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  static const _orderDeviderIndent = 120.0;

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
    var totalOrderCost = _orders.fold(
        0.0,
        (totalCost, nextOrder) =>
            (totalCost + nextOrder.count * nextOrder.cost));

    return CloseablePage(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    I18n.of(context).checkoutTitle,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(height: 29),
                  Text(
                    I18n.of(context).shippingAddress,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: Insets.x2),
                  _buildShippAddress(),
                  _buildDevider(),
                  Text(
                    I18n.of(context).paymentMethod,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: Insets.x2),
                  _buildRowAction(
                    imagePath: CREDIT_CARD_IMAGE,
                    text: Text(
                      I18n.of(context).cardEnding,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(fontWeight: FontWeight.w700),
                    ),
                  ),
                  _buildDevider(),
                  Text(
                    I18n.of(context).items,
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(height: Insets.x3_5),
                  Expanded(
                    child: _buildOrderListView(),
                  ),
                  _buildDevider(),
                  TextFormField(
                    
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter a search term'),
                  ),
                  _buildRowAction(
                    imagePath: SALE_IMAGE,
                    text: Text(
                      I18n.of(context).addPromoCode,
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: BrandingColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ),
          TotalOrderWidget(
            cost: totalOrderCost,
            backgroundColor: BrandingColors.background,
            onButtonPressedFunction: () {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => SuccesPage()),
              );
            },
            buttonText: I18n.of(context).placeOrderButton,
            padding: EdgeInsets.fromLTRB(25, 15, 20, 15),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderListView() {
    return ListView.separated(
      itemCount: 20,
      itemBuilder: (BuildContext context, int index) {
        return SmallOrderWidget(
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
            color: BrandingColors.secondary,
            indent: 83.0,
          ),
        );
      },
    );
  }

  Widget _buildShippAddress() {
    return Row(
      children: <Widget>[
        Container(
          width: 136,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'John Doe', //TODO from provider
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'No 123, Sub Street, Main Street,City Name, Province, Country',
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    .copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
        Spacer(),
        CircleIcon(),
      ],
    );
  }

  Widget _buildRowAction({String imagePath, Text text}) {
    return Row(
      children: <Widget>[
        Image.asset(
          imagePath,
          fit: BoxFit.scaleDown,
        ),
        const SizedBox(width: Insets.x3_5),
        text,
        Spacer(),
        CircleIcon(),
      ],
    );
  }

  Widget _buildDevider() {
    return Divider(
      color: BrandingColors.secondary.withOpacity(0.15),
      thickness: 1.0,
      height: 32.0,
    );
  }
}
