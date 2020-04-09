import 'package:shared_preferences/shared_preferences.dart';

import 'package:ecommers/core/models/login_model.dart';

class MembershipService {
  static const String _accessTokenKey = 'accessTokenKey';
  static const String _refreshTokenKey = 'refreshTokenKey';
  static const String _expirationDateKey = 'expirationDateKey';

  SharedPreferences _storage;

  String _accessToken;
  String _refreshToken;
  DateTime _expirationDate;

  String get accessToken => _accessToken;
  String get refreshToken => _refreshToken;
  bool get isNotExpired =>
      _expirationDate != null && DateTime.now().isBefore(_expirationDate);

  MembershipService();

  Future initialize() async {
    _storage = await SharedPreferences.getInstance();
    load();
  }

  void refresh(LoginModel loginModel) {
    _accessToken = loginModel.token;
    _refreshToken = loginModel.refreshToken;
    _expirationDate = DateTime.parse(loginModel.expirationDate);

    _saveToStorage(loginModel);
  }

  void clear() {
    _accessToken = null;
    _refreshToken = null;
    _expirationDate = null;

   _clearStorage();
  }

  void _clearStorage() {
    _storage.remove(_accessTokenKey);
    _storage.remove(_refreshTokenKey);
    _storage.remove(_expirationDateKey);
  }

  void load() {
    _accessToken = _storage.getString(_accessTokenKey);
    _refreshToken = _storage.getString(_refreshTokenKey);
    _expirationDate =
        DateTime.tryParse(_storage.getString(_expirationDateKey) ?? '');
  }

  void _saveToStorage(LoginModel loginModel) {
    _storage.setString(_accessTokenKey, loginModel.token);
    _storage.setString(_refreshTokenKey, loginModel.refreshToken);
    _storage.setString(_expirationDateKey, loginModel.expirationDate);
  }
}
