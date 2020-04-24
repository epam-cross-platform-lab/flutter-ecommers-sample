import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;

class ShippingAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
        title: Center(
          child: Text(
            'Shipping address',
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w700),
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
      body: _navButton(context),
    );
  }

  Widget _navButton(BuildContext context) {
    return Center(
      child: RaisedButton(
        onPressed: () => navigationService.navigateTo(Pages.addShippingAddress),
        child: const Text('add address', style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
