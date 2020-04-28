import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/payment_method_model.dart';
import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/shared/dependency_service.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/bank_card.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:provider/provider.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  GlobalKey<AnimatedListState> _listKey;
  PaymentMethodProviderModel _provider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _provider = Provider.of<PaymentMethodProviderModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    _listKey = GlobalKey();

    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
        title: Center(
          child: Text(
            localization.paymentMethodTitle,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        actions: <Widget>[
          Visibility(
            visible: _provider.paymentMethods.isNotEmpty,
            child: IconButton(
              icon: const Icon(Icons.add),
              color: BrandingColors.primary,
              onPressed: () =>
                  navigationService.navigateTo(Pages.addPaymentMethod),
            ),
          ),
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_provider.paymentMethods.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(localization.notBankCards,
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: Insets.x6_5),
            SizedBox(
              width: 164.0,
              height: 46.0,
              child: PrimaryButtonWidget(
                onPressedFunction: () async =>
                    navigationService.navigateTo(Pages.addPaymentMethod),
                text: localization.addCard,
              ),
            )
          ],
        ),
      );
    }
    return AnimatedList(
      key: _listKey,
      initialItemCount: _provider.paymentMethods.length,
      itemBuilder: (context, index, animation) =>
          _buildItem(_provider.paymentMethods[index], animation, index),
    );
  }

  Widget _buildItem(
      PaymentMethodModel item, Animation<double> animation, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Insets.x4, horizontal: Insets.x6),
      child: SizeTransition(
        sizeFactor: animation,
        child: BankCard(
          lastFourNumber: item.cardNumberLast4,
          deleteFunction: () => _removeItem(index),
          isSelect: item.isSelected,
          onTappedFunction: () => _provider.selectPaymentMethod(item),
        ),
      ),
    );
  }

  Future _removeItem(int removeIndex) async {
    if (removeIndex >= _provider.paymentMethods.length) return;
    final PaymentMethodModel removedItem =
        await _provider.removePaymentMethod(removeIndex);

    _listKey.currentState.removeItem(
      removeIndex,
      (context, animation) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Insets.x4, horizontal: Insets.x6),
        child: SizeTransition(
          sizeFactor: animation,
          child: BankCard(
            lastFourNumber: removedItem.cardNumberLast4,
          ),
        ),
      ),
    );
  }
}
