import 'package:ecommers/core/common/index.dart';

class LatestProductQueryParams {
  final int from;
  final int to;

  LatestProductQueryParams({this.from, this.to});

  factory LatestProductQueryParams.fromQueryParameters(
      Map<String, String> params) {
    return LatestProductQueryParams(
        from: params[ApiQueryParams.rangeFrom] == null
            ? null
            : int.tryParse(params[ApiQueryParams.rangeFrom]),
        to: params[ApiQueryParams.rangeTo] == null
            ? null
            : int.tryParse(params[ApiQueryParams.rangeTo]));
  }
}
