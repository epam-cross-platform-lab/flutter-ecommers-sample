import 'package:flutter/services.dart';

class FileManager {
  static const String jsonPath = 'assets/data/';

  Future<String> readJson(String fileName) async {
    return rootBundle.loadString('$jsonPath$fileName');
  }
}