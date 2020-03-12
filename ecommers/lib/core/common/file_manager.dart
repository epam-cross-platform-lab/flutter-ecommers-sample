import 'package:flutter/services.dart';

class FileManager {
  static const String jsonPath = 'lib/web_server/data/';

  Future<String> readJson(String fileName) async {
    return rootBundle.loadString('$jsonPath$fileName');
  }
}