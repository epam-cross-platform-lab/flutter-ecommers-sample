import 'package:chopper/chopper.dart';

typedef JsonFactory<T> = T Function(Map<String, dynamic> json);

class JsonSerializableConverter extends JsonConverter {
  final Map<Type, JsonFactory> _factories;

  const JsonSerializableConverter({Map<Type, JsonFactory> factories})
      : _factories = factories;

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = _factories[T];
    if (jsonFactory == null || jsonFactory is! JsonFactory<T>) {
      return throw 'not found factory';
    }

    return jsonFactory(values) as T;
  }

  List<T> _decodeList<T>(List values) =>
      values.where((v) => v != null).map<T>((v) => _decode<T>(v) as T).toList();

  dynamic _decode<T>(entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity as List);
    }

    if (entity is Map) {
      return _decodeMap<T>(entity as Map<String, dynamic>);
    }

    return entity;
  }

  @override
  Response<ResultType> convertResponse<ResultType, Item>(Response response) {
    final jsonRes = super.convertResponse(response);

    return jsonRes.copyWith<ResultType>(
        body: _decode<Item>(jsonRes.body) as ResultType);
  }
}
