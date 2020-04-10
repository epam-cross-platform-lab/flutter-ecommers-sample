import 'dart:convert';

extension JsonExtension on JsonCodec {
  List<T> decodeList<T>(String json, T Function(Map<String, dynamic>) fromMap) {
    final jsonMap =
        (jsonDecode(json) as List).cast<Map<String, dynamic>>();

    return jsonMap.map((e) => fromMap(e)).toList();
  }
}
