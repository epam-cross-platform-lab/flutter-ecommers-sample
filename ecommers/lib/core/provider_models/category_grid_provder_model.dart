import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/index.dart';
import 'package:ecommers/core/provider_models/provider_model_base.dart';
import 'package:ecommers/core/services/index.dart';
import 'package:flutter/material.dart';

class CategoryGridProviderModel extends ProviderModelBase {
  CategoryGridProviderModel(BuildContext context) : super(context);

  Future<List<ProductModel>> getData(Categories type) async {
    isBusy = true;

    final response = await apiService.products(type);

    if (response.isSuccessful) {
      return response.body;
    }

    isBusy = false;

    return null;
  }
}
