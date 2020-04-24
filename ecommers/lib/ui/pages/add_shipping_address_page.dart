import 'package:ecommers/ui/decorations/index.dart';
import 'package:ecommers/ui/widgets/index.dart';
import 'package:flutter/material.dart' hide BackButton;

class AddShippingAddress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BrandingColors.pageBackground,
      appBar: AppBar(
        leading: const BackButton(),
      ),
      body: const Center(
        child: Text('Adress'),
      ),
    );
  }
}
