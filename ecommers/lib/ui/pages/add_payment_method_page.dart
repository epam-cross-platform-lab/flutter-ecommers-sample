import 'package:ecommers/core/provider_models/payment_method_provider_model.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddPaymentMethodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider =
        Provider.of<PaymentMethodProviderModel>(context, listen: false);
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
                onChanged: (text) => provider.creditCard.number = text,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: Insets.x4),
              CreditCardTextField(
                hintText: localization.namePlaceHolder,
                onChanged: (text) => provider.creditCard.name = text,
                maxLength: 26,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: Insets.x4),
              Row(
                children: <Widget>[
                  CreditCardTextField(
                    width: 208.0,
                    hintText: localization.exprDatePlaceHolder,
                    onChanged: (text) => provider.expDate = text,
                    maxLength: 5,
                    keyboardType: TextInputType.datetime,
                  ),
                  const Spacer(),
                  CreditCardTextField(
                    width: 104.0,
                    hintText: localization.cvc,
                    maxLength: 3,
                    onChanged: (text) => provider.creditCard.cvc = text,
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
                  onPressedFunction: () async => provider.addPaymentMethod(),
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
