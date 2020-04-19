import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/bank_card.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;

class PaymentMethodPage extends StatefulWidget {
  @override
  _PaymentMethodPageState createState() => _PaymentMethodPageState();
}

class _PaymentMethodPageState extends State<PaymentMethodPage> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  final List<String> _list = ['1234', '2345', '5678', '4567', '9775'];

  @override
  Widget build(BuildContext context) {
    final localization = I18n.of(context);
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
          IconButton(
            icon: Icon(Icons.add),
            color: BrandingColors.primary,
            onPressed: () {},
          ),
        ],
      ),
      body: _buildBody(context), //todo body
    );
  }

  Widget _buildBody(BuildContext context) {
    if (context == null) {
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
                onPressedFunction: () {},
                text: I18n.of(context).addCard,
              ),
            )
          ],
        ),
      );
    }
    return AnimatedList(
      key: _listKey,
      initialItemCount: _list.length,
      itemBuilder: (context, index, animation) =>
          _buildItem(_list[index], animation, index),
    );
  }

  Widget _buildItem(String item, Animation<double> animation, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Insets.x4, horizontal: Insets.x6),
      child: SizeTransition(
        sizeFactor: animation,
        child: BankCard(
          lastFourNumber: item,
          deleteFunction: () => _removeSingleItems(index),
        ),
      ),
    );
  }

  void _removeSingleItems(int removeIndex) {
    final String removedItem = _list.removeAt(removeIndex);

    _listKey.currentState.removeItem(
      removeIndex,
      (context, animation) => Padding(
        padding: const EdgeInsets.symmetric(
            vertical: Insets.x4, horizontal: Insets.x6),
        child: SizeTransition(
          sizeFactor: animation,
          child: BankCard(
            lastFourNumber: removedItem,
          ),
        ),
      ),
    );
  }
}
