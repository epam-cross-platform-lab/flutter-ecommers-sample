import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/assets.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/closeable_page.dart';
import 'package:ecommers/ui/pages/succes_page.dart';
import 'package:ecommers/ui/widgets/circle_icon.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/order/index.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_visibility/keyboard_visibility.dart';

class CheckoutPage extends StatefulWidget {
  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  bool totalOrderVisible = true;
  final keyboardVisibilityNotification = KeyboardVisibilityNotification();

  @protected
  void initState() {
    super.initState();
    keyboardVisibilityNotification.addNewListener(
      onChange: (bool visible) {
        setState(() {
          totalOrderVisible = !visible;
        });
      },
    );
  }

  @override
  void dispose() {
    keyboardVisibilityNotification.dispose();
    super.dispose();
  }

  static const int _itemCount = 20;

  static String _getDressAssetPath(int index) {
    var modulo = index % 7;

    if (modulo == 0) return DRESS_COTTON_IMAGE;
    if (modulo == 1) return DRESS_FLORAL2_IMAGE;
    if (modulo == 2) return DRESS_FLORAL_IMAGE;
    if (modulo == 3) return DRESS_PATTERN2_IMAGE;
    if (modulo == 4) return DRESS_PATTERN_IMAGE;
    if (modulo == 5) return DRESS_COTTON2_IMAGE;
    if (modulo == 6)
      return GREEN_BACKPACK_IMAGE;
    else {
      return GREEN_BACKPACK_IMAGE;
    }
  }

  final _orders = List.generate(
      _itemCount,
      (index) => OrderModel(
          title: 'Bottle Green Backpack',
          description: 'Medium, Green',
          cost: 2.58,
          imagePath: _getDressAssetPath(index),
          count: 1));

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
            child: BackgroundedSafeArea(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                    Insets.x6, Insets.x0, Insets.x5, Insets.x4),
                child: _buildOrderListView(),
              ),
            ),
          ),
          Visibility(
            visible: totalOrderVisible,
            child: TotalOrderWidget(
              cost: totalOrderCost,
              backgroundColor: BrandingColors.background,
              onButtonPressedFunction: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(builder: (context) => SuccesPage()),
                );
              },
              buttonText: I18n.of(context).placeOrderButton,
              padding: EdgeInsets.fromLTRB(25, 8, 20, 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          I18n.of(context).checkoutTitle,
          style: Theme.of(context).textTheme.headline6,
        ),
        const SizedBox(height: 20),
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
        const SizedBox(height: 14.0),
      ],
    );
  }

  Widget _buildListFooter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildDevider(),
        TextField(
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Message to seller (optional)',
              hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
                  fontWeight: FontWeight.w300, fontStyle: FontStyle.italic)),
        ),
        _buildDevider(),
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
    );
  }

  Widget _buildOrderListView() {
    int newItemCount = _orders.length + 2;
    return ListView.separated(
      itemCount: newItemCount,
      itemBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return _buildListHeader();
        }

        if (index == newItemCount - 1) {
          return _buildListFooter();
        }

        return SmallOrderWidget(
          primaryText: _orders[index - 1].title,
          secondaryText: _orders[index - 1].description,
          assetImagePath: _orders[index - 1].imagePath,
          cost: _orders[index - 1].cost,
          count: _orders[index - 1].count,
          countIncrementFunction: () => incrementCount(_orders[index - 1]),
          countDecrementFunction: () => decrementCount(_orders[index - 1]),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        if (index == 0) {
          return const SizedBox(height: 0);
        }
        if (index == newItemCount - 2) {
          return const SizedBox(height: 0);
        }
        return Padding(
          padding:
              EdgeInsets.fromLTRB(Insets.x0, Insets.x3, Insets.x0, Insets.x4),
          child: Divider(
            color: BrandingColors.secondary.withOpacity(0.4),
            indent: 83.0,
          ),
        );
      },
    );
  }

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
      height: 24.0,
    );
  }
}
