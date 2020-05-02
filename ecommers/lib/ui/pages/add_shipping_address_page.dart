import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
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

class AddShippingAddress extends StatefulWidget {
  final ShippingAddressModel shippingAddres;
  const AddShippingAddress({this.shippingAddres, Key key}) : super(key: key);

  @override
  _AddShippingAddressState createState() => _AddShippingAddressState();
}

class _AddShippingAddressState extends State<AddShippingAddress> {
  TextEditingController _fullNameController,
      _addressController,
      _cityController,
      _stateController,
      _zipCodeController,
      _countryController;
  ShippingAddressProviderModel provider;

  @override
  void initState() {
    _fullNameController =
        TextEditingController(text: widget.shippingAddres?.fullName);
    _addressController =
        TextEditingController(text: widget.shippingAddres?.address);
    _cityController = TextEditingController(text: widget.shippingAddres?.city);
    _stateController =
        TextEditingController(text: widget.shippingAddres?.state);
    _zipCodeController =
        TextEditingController(text: widget.shippingAddres?.zipCode);
    _countryController =
        TextEditingController(text: widget.shippingAddres?.country);

    provider =
        Provider.of<ShippingAddressProviderModel>(context, listen: false);
    super.initState();
  }

  @override
  void dispose() {
    disposeControllers();
    provider.clean();
    super.dispose();
  }

  void disposeControllers() {
    _fullNameController.dispose();
    _addressController.dispose();
    _cityController.dispose();
    _stateController.dispose();
    _zipCodeController.dispose();
    _countryController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.shippingAddres != null) {
      provider?.shippingAddress = widget.shippingAddres;
    }
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
          padding: const EdgeInsets.symmetric(
              vertical: Insets.x4, horizontal: Insets.x6),
          child: Consumer<ShippingAddressProviderModel>(
            builder: (_, provider, __) {
              return Column(
                children: <Widget>[
                  const SizedBox(height: Insets.x4),
                  ShippingAddressTextField(
                    labelText: localization.fullName,
                    maxLength: 25,
                    onValidate: (text) => Validator.isEmail(text)
                        ? null
                        : localization.emailError,
                    controller: _fullNameController,
                    onChanged: (text) =>
                        provider.shippingAddress.fullName = text,
                    keyboardType: TextInputType.text,
                    isValid: provider.isValidFullName,
                  ),
                  const SizedBox(height: Insets.x4),
                  ShippingAddressTextField(
                    labelText: localization.address,
                    controller: _addressController,
                    onChanged: (text) =>
                        provider?.shippingAddress?.address = text,
                    keyboardType: TextInputType.text,
                    isValid: provider.isValidAddress,
                  ),
                  const SizedBox(height: Insets.x4),
                  ShippingAddressTextField(
                    labelText: localization.city,
                    controller: _cityController,
                    maxLength: 20,
                    onChanged: (text) => provider.shippingAddress.city = text,
                    keyboardType: TextInputType.text,
                    isValid: provider.isValidCity,
                  ),
                  const SizedBox(height: Insets.x4),
                  ShippingAddressTextField(
                    labelText: localization.stateProvinceRegion,
                    controller: _stateController,
                    maxLength: 20,
                    onChanged: (text) => provider.shippingAddress.state = text,
                    keyboardType: TextInputType.text,
                    isValid: provider.isValidStateProvinceRegion,
                  ),
                  const SizedBox(height: Insets.x4),
                  ShippingAddressTextField(
                    labelText: localization.zipCode,
                    controller: _zipCodeController,
                    maxLength: 20,
                    onChanged: (text) =>
                        provider.shippingAddress.zipCode = text,
                    keyboardType: TextInputType.number,
                    isValid: provider.isValidZipCode,
                  ),
                  const SizedBox(height: Insets.x4),
                  ShippingAddressTextField(
                    labelText: localization.country,
                    controller: _countryController,
                    maxLength: 20,
                    onChanged: (text) =>
                        provider.shippingAddress.country = text,
                    keyboardType: TextInputType.text,
                    isValid: provider.isValidCountry,
                  ),
                  const SizedBox(height: Insets.x8),
                  SizedBox(
                    height: 46.0,
                    child: PrimaryButtonWidget(
                      onPressedFunction: () async =>
                          provider.addOrEditShippingAddress(),
                      text: localization.addShippingAddress,
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
