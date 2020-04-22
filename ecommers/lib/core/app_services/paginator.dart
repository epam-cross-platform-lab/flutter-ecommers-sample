import 'package:ecommers/core/models/data_models/index.dart';

class Paginator {
  static const int _pageSize = 20;

  int _currentPosition = 0;
  bool _hasMore = true;

  int get currentPosition => _currentPosition;
  bool get hasMore => _hasMore;

  Future<List<Product>> loadNextPage(
      Future<List<Product>> Function(int, int) request) async {
    final List<Product> portion =
        await request(currentPosition, currentPosition + _pageSize);

    if (portion == null || portion.length < _pageSize) {
      _hasMore = false;
    } else {
      _currentPosition += _pageSize;
    }

    return portion ?? [];
  }

  void reset() {
    _hasMore = true;
    _currentPosition = 0;
  }
}
