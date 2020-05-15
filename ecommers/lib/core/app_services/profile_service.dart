import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  FirebaseUser _user;
  FirebaseUser get user => _user;

  Future updateUserInfo() async {
    _user = await FirebaseAuth.instance.currentUser();
  }
}
