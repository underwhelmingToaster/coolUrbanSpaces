import 'package:flutter/cupertino.dart';

class SettingsController extends ChangeNotifier{

  String _browsingSort = "Name";
  bool _exampleSwitch = true;


  bool get exampleSwitch => _exampleSwitch;

  set exampleSwitch(bool value) {
    _exampleSwitch = value;
    notifyListeners();
  }

  String get browsingSort => _browsingSort;

  set browsingSort(String value) {
    _browsingSort = value;
    notifyListeners();
  }


}