import 'package:ecommers/core/models/data_models/index.dart';

class Paginator {
  static const int _pageSize = 10;

  int _lastId;
  bool _hasMore = true;

  bool get hasMore => _hasMore;

  Future<List<Product>> loadNextPage(
      Future<List<Product>> Function(int, int) request) async {
    final portion = await request(_lastId, _pageSize);

    if (portion == null || portion.length < _pageSize) {
      _hasMore = false;
    } else {
      _lastId = portion.last.id;
    }

    return portion ?? [];
  }

  void reset() {
    _hasMore = true;
    _lastId = null;
  }
}
