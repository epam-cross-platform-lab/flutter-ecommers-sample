import 'package:ecommers/core/models/login_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MembershipService {
  static const String _accessTokenKey = 'accessTokenKey';
  static const String _refreshTokenKey = 'refreshTokenKey';
  static const String _expirationDateKey = 'expirationDateKey';
  
  int get id => 1;//todo replace to profile

  final FlutterSecureStorage secureStorage;

  String _accessToken;
  String _refreshToken;
  DateTime _expirationDate;

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  bool get isNotExpired =>
      _expirationDate != null && DateTime.now().isBefore(_expirationDate);

  MembershipService(this.secureStorage);

  Future refresh(LoginModel loginModel) async {
    _accessToken = loginModel.token;
    _refreshToken = loginModel.refreshToken;
    _expirationDate = DateTime.parse(loginModel.expirationDate);

    await _saveToStorage(loginModel);
  }

  Future clear() async {
    _accessToken = null;
    _refreshToken = null;
    _expirationDate = null;

    await _clearStorage();
  }

  Future _clearStorage() async {
    await Future.wait(
      {
        secureStorage.delete(key: _accessTokenKey),
        secureStorage.delete(key: _refreshTokenKey),
        secureStorage.delete(key: _expirationDateKey),
      },
    );
  }

  Future load() async {
    _accessToken = await secureStorage.read(key: _accessTokenKey);
    _refreshToken = await secureStorage.read(key: _refreshTokenKey);
    _expirationDate = DateTime.tryParse(
        await secureStorage.read(key: _expirationDateKey) ?? '');
  }

  Future _saveToStorage(LoginModel loginModel) async {
    await Future.wait(
      {
        secureStorage.write(key: _accessTokenKey, value: loginModel.token),
        secureStorage.write(
            key: _refreshTokenKey, value: loginModel.refreshToken),
        secureStorage.write(
            key: _expirationDateKey, value: loginModel.expirationDate),
      },
    );
  }
}
