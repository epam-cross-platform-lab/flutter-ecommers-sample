import 'package:ecommers/core/common/index.dart';
import 'package:ecommers/core/models/sort_type.dart';
import 'package:enum_to_string/enum_to_string.dart';

class ProductQueryParams {
  final Categories category;
  final String subCategory;
  final int rangeFrom;
  final int rangeTo;
  final String searchQuery;
  final SortType sortType;

  ProductQueryParams({
    this.category,
    this.subCategory,
    this.rangeFrom,
    this.rangeTo,
    this.searchQuery,
    this.sortType,
  });

  factory ProductQueryParams.fromQueryParameters(Map<String, String> params) {
    return ProductQueryParams(
        category: EnumToString.fromString(
            Categories.values, params[ApiQueryParams.category]),
        subCategory: params[ApiQueryParams.subCategory],
        rangeFrom: params[ApiQueryParams.rangeFrom] == null
            ? null
            : int.tryParse(params[ApiQueryParams.rangeFrom]),
        rangeTo: params[ApiQueryParams.rangeTo] == null
            ? null
            : int.tryParse(params[ApiQueryParams.rangeTo]),
        searchQuery: params[ApiQueryParams.searchQuery],
        sortType: EnumToString.fromString(
            SortType.values, params[ApiQueryParams.sortType]));
  }
}
