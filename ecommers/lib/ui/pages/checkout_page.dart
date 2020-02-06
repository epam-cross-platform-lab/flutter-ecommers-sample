import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/models/order_model.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/order_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: BrandingColors.pageBackground,
      ),
      backgroundColor: BrandingColors.pageBackground,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(25, 0, 20, 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text(
                    I18n.of(context).checkoutTitle,
                    //style: Styles.titleText,
                  ),
                  SizedBox(height: 29),
                  Expanded(
                    child: _buildOrderListView(),
                  ),
                ],
              ),
            ),
          ),
          TotalOrderWidget(
            cost: totalOrderCost,
            backgroundColor: BrandingColors.background,
            onButtonPressedFunction: () {},
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
            color: BrandingColors.secondary,
            indent: _orderDeviderIndent,
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
                I18n.of(context).shippingAddress,
               // style: Styles.orderPrimaryText,
              ),
              SizedBox(
                height: 8.0,
              ),
              Text(
                'John Doe', //TODO from provider
               // style: Styles.orderSecondaryText,
              ),
              Text(
                'No 123, Sub Street, Main Street,City Name, Province, Country',
             //   style: Styles.orderPrimaryText,
              ),
            ],
          ),
        ),
        Expanded(
          child: Align(
            child: SvgPicture.asset(MENU_ARROW_ICON),
            alignment: Alignment.centerRight,
          ),
        )
      ],
    );
  }
  Widget _buildPaymentMethodWidget(){
    
  }
}
