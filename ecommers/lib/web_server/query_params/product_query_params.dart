import 'package:enum_to_string/enum_to_string.dart';

import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/sort_type.dart';

class ProductQueryParams {
  final Categories category;
  final String subCategory;
  final int from;
  final int to;
  final String searchQuery; 
  final SortType sortType;

  ProductQueryParams({
    this.category,
    this.subCategory,
    this.from,
    this.to,
    this.searchQuery,
    this.sortType,
  });

  factory ProductQueryParams.fromQueryParameters(Map<String, String> params) {
    return ProductQueryParams(
        category: EnumToString.fromString(
            Categories.values, params[ApiQueryParams.category]),
        subCategory: params[ApiQueryParams.subCategory],
        from: params[ApiQueryParams.rangeFrom] == null
            ? null
            : int.tryParse(params[ApiQueryParams.rangeFrom]),
        to: params[ApiQueryParams.rangeTo] == null
            ? null
            : int.tryParse(params[ApiQueryParams.rangeTo]),
        searchQuery: params[ApiQueryParams.searchQuery],
        sortType: EnumToString.fromString(
            SortType.values, params[ApiQueryParams.sortType]));
  }
}
