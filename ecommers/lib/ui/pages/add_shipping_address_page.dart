import 'package:ecommers/core/provider_models/index.dart';
import 'package:ecommers/generated/i18n.dart';
import 'package:ecommers/ui/decorations/dimens/index.dart';
import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/button/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:ecommers/ui/widgets/shipping_address_text_field.dart';
import 'package:flutter/material.dart' hide BackButton;
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddShippingAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
      final provider =
        Provider.of<ShippingAddressProviderModel>(context, listen: false);
    final localization = I18n.of(context); 
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
        title: Center(
          child: Text(
            localization.addingShippingAddress,
            style: Theme.of(context)
                .textTheme
                .bodyText1
                .copyWith(fontWeight: FontWeight.w700),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              EdgeInsets.symmetric(vertical: Insets.x4, horizontal: Insets.x6),
          child: Column(
            children: <Widget>[
              const SizedBox(height: Insets.x4),
              ShippingAddressTextField(
                labelText: localization.fullName,
                maxLength: 26,
                // onChanged: (text) => provider.creditCard.number = text,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: Insets.x4),
              ShippingAddressTextField(
                labelText: localization.address,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: Insets.x4),
              ShippingAddressTextField(
                labelText: localization.city,
                maxLength: 20,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: Insets.x4),
              ShippingAddressTextField(
                labelText: localization.stateProvinceRegion,
                maxLength: 20,
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: Insets.x4),
              ShippingAddressTextField(
                labelText: localization.zipCode,
                maxLength: 20,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: Insets.x4),
              ShippingAddressTextField(
                labelText: localization.country,
                maxLength: 20,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: Insets.x8),
              SizedBox(
                height: 46.0,
                child: PrimaryButtonWidget(
                  //onPressedFunction: () async => provider.addShippingAddress(),
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
