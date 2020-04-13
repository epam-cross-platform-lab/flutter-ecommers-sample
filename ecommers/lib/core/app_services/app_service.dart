import 'package:chopper/chopper.dart';

class AppService {
  Future<T> fetchData<T>(
      Future<Response<T>> Function() requestFunction) async {
    final response = await requestFunction();

    if (response.isSuccessful) {
      return response.body;
    }

    return null;
  }
}
