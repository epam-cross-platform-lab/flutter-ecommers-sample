import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/shipping_address_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:provider/provider.dart';

class ShippingAddressPage extends StatefulWidget {
  @override
  _ShippingAddressState createState() => _ShippingAddressState();
}

class _ShippingAddressState extends State<ShippingAddressPage> {
  GlobalKey<AnimatedListState> _listKey;
  ShippingAddressProviderModel _provider;
  @override
  Widget build(BuildContext context) {
    _listKey = GlobalKey();
    _provider = Provider.of<ShippingAddressProviderModel>(context);
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
        title: Center(
          child: Text(
            localization.smallShippingAddress,
            style: textTheme.bodyText1.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            color: BrandingColors.primary,
            onPressed: () =>
                navigationService.navigateTo(Pages.addShippingAddress),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_provider.shippingAddresses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(localization.notShippingAddress, style: textTheme.bodyText1),
            const SizedBox(height: Insets.x6_5),
            SizedBox(
              width: 264.0,
              height: 46.0,
              child: PrimaryButtonWidget(
                onPressedFunction: () async =>
                    navigationService.navigateTo(Pages.addShippingAddress),
                text: localization.addShippingAddress,
              ),
            )
          ],
        ),
      );
    }
    return AnimatedList(
      key: _listKey,
      initialItemCount: _provider.shippingAddresses.length,
      itemBuilder: (context, index, animation) =>
          _buildItem(_provider.shippingAddresses[index], animation, index),
    );
  }

  Widget _buildItem(
      ShippingAddressModel item, Animation<double> animation, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Insets.x2, horizontal: Insets.x2),
      child: SizeTransition(
        sizeFactor: animation,
        child: AddressCard(
          itemShippingAddress: item,
          editFunction: () => navigationService
              .navigateTo(Pages.addShippingAddress, arguments: item),
          deleteFunction: () => _removeItem(index),
          isSelect: item.isSelected,
          onTappedFunction: () => _provider.selectShippingAddress(item),
        ),
      ),
    );
  }

  Future _removeItem(int removeIndex) async {
    if (removeIndex >= _provider.shippingAddresses.length) return;
    final ShippingAddressModel removedItem =
        await _provider.removeShippingAddress(removeIndex);

    _listKey.currentState.removeItem(
      removeIndex,
      (context, animation) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Insets.x4, horizontal: Insets.x6),
        child: SizeTransition(
          sizeFactor: animation,
          child: AddressCard(
            itemShippingAddress: removedItem,
          ),
        ),
      ),
    );
  }
}
