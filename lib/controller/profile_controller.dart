import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';

class ProfileController extends ChangeNotifier {
  final String salt = "I'm very salty";

  String _username = "";

  List<String> _passwords = ["", "", ""]; //

  bool register() {
    String passwordHash =
        Crypt.sha256(_passwords[1], rounds: 1000, salt: salt).hash.toString();
    String passwordHash2 =
        Crypt.sha256(_passwords[2], rounds: 1000, salt: salt).hash.toString();
    if (username.isNotEmpty &&
        passwordHash.isNotEmpty &&
        passwordHash2.isNotEmpty) {
      if (passwordHash2 == passwordHash) {
        // TODO: Further process password and username
        return true;
      }
    }
    return false;
  }

  bool login() {
    String passwordHash =
        Crypt.sha256(_passwords[0], rounds: 1000, salt: salt).hash.toString();
    if (username.isNotEmpty && passwordHash.isNotEmpty) {
      // TODO: Further process password and username
      return true;
    }
    return false;
  }

  bool changeProfile() {
    String passwordHash =
        Crypt.sha256(_passwords[0], rounds: 1000, salt: salt).hash.toString();
    String newPasswordHash =
        Crypt.sha256(_passwords[1], rounds: 1000, salt: salt).hash.toString();
    String newPasswordHash2 =
        Crypt.sha256(_passwords[2], rounds: 1000, salt: salt).hash.toString();
    if (username.isNotEmpty &&
        passwordHash.isNotEmpty &&
        newPasswordHash.isNotEmpty &&
        newPasswordHash2.isNotEmpty) {
      if (newPasswordHash == newPasswordHash2) {
        // TODO: Further process password and username
        return true;
      }
    }
    return false;
  }

  void clearFields() {
    _passwords = ["", "", ""];
    notifyListeners();
  }

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _passwords[0] = value;
    notifyListeners();
  }

  set newpassword(String value) {
    _passwords[1] = value;
    notifyListeners();
  }

  set repeatNewPassword(String value) {
    _passwords[2] = value;
    notifyListeners();
  }
}
