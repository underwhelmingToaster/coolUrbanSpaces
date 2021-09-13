import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';

class ProfileController extends ChangeNotifier {
  final String salt = "I'm very salty";

  String _username = "";

  List<String> _passwords = ["", ""];

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set password(String value) {
    _passwords[0] = value;
    notifyListeners();
  }

  set scndpassword(String value) {
    _passwords[1] = value;
    notifyListeners();
  }

  bool submit(){
    String passwordHash = Crypt.sha256(_passwords[0], rounds: 1000, salt: salt).hash.toString();
    String passwordHash2 = Crypt.sha256(_passwords[1], rounds: 1000, salt: salt).hash.toString();
    if(username.isNotEmpty && passwordHash.isNotEmpty && passwordHash2.isNotEmpty) {
      if (passwordHash2 == passwordHash) {
        // TODO: Further process password and username
        return true;
      }
    }

    return false;
  }
}