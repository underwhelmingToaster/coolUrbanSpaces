import 'package:flutter/cupertino.dart';

class SettingsController extends ChangeNotifier{
  bool _exampleSwitch = true;

  bool get exampleSwitch => _exampleSwitch;

  set exampleSwitch(bool value) {
    _exampleSwitch = value;
    notifyListeners();
  }
}