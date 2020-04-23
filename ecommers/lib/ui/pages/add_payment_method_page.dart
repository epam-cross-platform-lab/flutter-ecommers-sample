import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter/services.dart';

class AddPaymentMethodPage extends StatelessWidget {
  BuildContext _context;
  @override
  Widget build(BuildContext context) {
    // final provider =
    // Provider.of<PaymentMethodProviderModel>(context, listen: false);
    _context = context;
    final localization = I18n.of(context);
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Insets.x4, horizontal: Insets.x6),
          child: Column(
            children: <Widget>[
              Center(
                child: Image.asset(
                  Assets.bigCreditCard,
                  fit: BoxFit.fill,
                ),
              ),
              const SizedBox(height: Insets.x4),
              CreditCardTextField(
                hintText: localization.creditCardNumberPlaceHolder,
                maxLength: 16,
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,
                ],
                //onChanged: (text) => provider.creditCard.number,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: Insets.x4),
              CreditCardTextField(
                hintText: localization.namePlaceHolder,
                maxLength: 26,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: Insets.x4),
              Row(
                children: <Widget>[
                  CreditCardTextField(
                    width: 208.0,
                    hintText: localization.exprDatePlaceHolder,
                    maxLength: 5,
                    keyboardType: TextInputType.datetime,
                  ),
                  const Spacer(),
                  CreditCardTextField(
                    width: 104.0,
                    hintText: localization.cvc,
                    maxLength: 3,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                ],
              ),
              const SizedBox(height: Insets.x4),
              SizedBox(
                height: 46.0,
                child: PrimaryButtonWidget(
                  onPressedFunction: () {},
                  text: I18n.of(context).addCardDetails,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

}
