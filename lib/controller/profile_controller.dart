import 'package:flutter/cupertino.dart';

class ProfileController extends ChangeNotifier {
  String _username = "";

  String get username => _username;

  set username(String value) {
    _username = value;
    notifyListeners();
  }
}