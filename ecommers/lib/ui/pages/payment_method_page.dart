import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/pages/index.dart';
import 'package:ecommers/ui/widgets/bank_card.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:provider/provider.dart';
import 'package:stripe_payment/stripe_payment.dart';

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  PaymentMethodProviderModel _provider;
  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
    return BasePage(
      createProvider: (context) => PaymentMethodProviderModel(context),
      child: Consumer<PaymentMethodProviderModel>(
        builder: (context, provider, child) {
          _provider = provider;
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
                  visible: provider.paymentMethods.isNotEmpty,
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: BrandingColors.primary,
                    onPressed: () async =>_insertItem(),
                  ),
                ),
              ],
            ),
            body: _buildBody(context),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    if (_provider.paymentMethods.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(I18n.of(context).notBankCards,
                style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: Insets.x6_5),
            SizedBox(
              width: 164.0,
              height: 46.0,
              child: PrimaryButtonWidget(
                onPressedFunction: () async => _insertItem(),
                text: I18n.of(context).addCard,
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
      PaymentMethod item, Animation<double> animation, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Insets.x4, horizontal: Insets.x6),
      child: SizeTransition(
        sizeFactor: animation,
        child: BankCard(
          lastFourNumber: item.card.last4,
          deleteFunction: () => _removeItem(index),
        ),
      ),
    );
  }

  void _removeItem(int removeIndex) {
    final PaymentMethod removedItem =
        _provider.removePaymentMethod(removeIndex);

    _listKey.currentState.removeItem(
      removeIndex,
      (context, animation) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Insets.x4, horizontal: Insets.x6),
        child: SizeTransition(
          sizeFactor: animation,
          child: BankCard(
            lastFourNumber: removedItem.card.last4,
          ),
        ),
      ),
    );
  }

  Future _insertItem() async {
    await _provider.addPaymentMethod();

    _listKey.currentState?.insertItem(_provider.paymentMethods.length - 1);
  }
}
