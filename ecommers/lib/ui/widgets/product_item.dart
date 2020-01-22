import 'package:ecommers/ui/decorations/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

enum ProductItemType { normal, wide, small }

class ProductItem extends StatelessWidget {
  static const double _padding = 10.0;

  final formatCurrency =
      NumberFormat.simpleCurrency(); //TODO: move out and create formatter

  final ProductItemType type;
  final String assetImagePath;
  final String title;
  final double cost;
  final String rate;

  ProductItem({
    @required this.assetImagePath,
    @required this.title,
    @required this.cost,
    this.type,
    this.rate,
  });

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ProductItemType.wide:
        return _buildWideProductItem();
      case ProductItemType.normal:
        return _buildNormalProductItem();
      default:
        return _buildSmallProductItem();
    }
  }

  Widget _buildWideProductItem() {
    return _buildContainerWidget(
      size: Dimens.productItemWideSize,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(assetImagePath),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Styles.productItemTitleText, //TODO: use wide style
              ),
              Stack(
                children: <Widget>[
                  Text(
                    formatCurrency.format(cost),
                    style: Styles.productItemCostText, //TODO: use wide style
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _buildRateWidget(),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNormalProductItem() {
    return _buildContainerWidget(
      size: Dimens.productItemNormalSize,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(assetImagePath),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title,
                style: Styles.productItemTitleText,
              ),
              Text(
                formatCurrency.format(cost),
                style: Styles.productItemCostText,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSmallProductItem() {
    return _buildContainerWidget(
      size: Dimens.productItemSmallSize,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Image.asset(assetImagePath),
          ),
          SizedBox(
            width: _padding,
          ),
          Expanded(
            flex: 7,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: Styles.productItemSmallTitleText,
                ),
                Text(
                  formatCurrency.format(cost),
                  style: Styles.productItemSmallCostText,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildContainerWidget({@required Size size, @required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(_padding),
      height: size.height,
      width: size.width,
      decoration: BoxDecoration(
        color: Palette.productItemBackground,
        borderRadius: BorderRadius.circular(Dimens.productItemBorderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: Dimens.defaultBlurRadius,
            color: Palette.productItemBlur,
            offset: Dimens.defaultBlurOffset,
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _buildRateWidget() {
    return Container(
      height: 16.0,
      width: 20.0,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Palette.rateBackground,
        borderRadius: BorderRadius.circular(14.0), //TODO: move out
      ),
      child: SvgPicture.asset(RATE_STAR_ICON),
      // height: 16.0,
      // width: 100.0,
      // decoration: BoxDecoration(
      //   color: Palette.rateBackground,
      //   borderRadius: BorderRadius.circular(14.0), //TODO: move out
      // ),
      // child: Image.asset(RATE_STAR_ICON),
    );
  }
}
