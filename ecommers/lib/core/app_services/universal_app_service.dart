import 'package:chopper/chopper.dart';

class UniversalAppService {
  Future<T> getDataFromBackend<T>(
      Future<Response<T>> Function() quryFunction) async {
    final response = await quryFunction();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
