import 'package:ecommers/web_server/data_access/validation_model.dart';
import 'package:ecommers/web_server/local_database.dart';
import 'package:ecommers/web_server/models/user.dart';
import 'package:ecommers/extensions/string_extension.dart';

class UserDataAccess {
  static const String userStoreKey = 'Users';

  static final UserDataAccess _instance = UserDataAccess._();
  static UserDataAccess get instance => _instance;

  final LocalDatabase _database = LocalDatabase.instance;

  UserDataAccess._();

  List<User> _allUsers;
  Future<List<User>> get allUsers => _getAllUsers();

  Future<List<User>> _getAllUsers() async {
    return _allUsers ??=
        await _database.getAll(userStoreKey, User.fromJsonFactory);
  }

  Future saveUser(Map<String, dynamic> userMap) async {
    _allUsers ??= [];
    _allUsers.add(User.fromJsonFactory(userMap));

    await _database.saveMap(userStoreKey, userMap);
  }

  Future<bool> isUserExists(User currentUser) async {
    final existedUser = (await allUsers).firstWhere(
        (user) =>
            (user.email == currentUser.email ||
                user.username == currentUser.username) &&
            user.password == currentUser.password,
        orElse: () => null);

    return existedUser != null;
  }

  Future<ValidationModel> isNewUserValid(User newUser) async {
    const fieldsEmptyError = 'Please fill in all fields';
    const emailExistsError = 'This email already exists';
    const usernameExists = 'This username already exists';

    final users = await allUsers;

    if (newUser.email.isNullOrEmpty ||
        newUser.username.isNullOrEmpty ||
        newUser.password.isNullOrEmpty) {
      return ValidationModel(isValid: false, error: fieldsEmptyError);
    }

    if (users == null) {
      return ValidationModel(isValid: true);
    }

    final existedUser = (await allUsers).firstWhere(
        (user) =>
            user.email == newUser.email || user.username == newUser.username,
        orElse: () => null);

    if (existedUser == null) {
      return ValidationModel(isValid: true);
    }

    if (existedUser.email == newUser.email) {
      return ValidationModel(isValid: false, error: emailExistsError);
    }

    return ValidationModel(isValid: false, error: usernameExists);
  }
}
