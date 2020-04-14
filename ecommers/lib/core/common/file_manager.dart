import 'package:flutter/services.dart';

class FileManager {
  static const String jsonPath = 'lib/web_server/data/';

  static Future<String> readJson(String fileName) async {
    final fullPath = jsonPath + fileName;
    return rootBundle.loadString(fullPath);
  }
}