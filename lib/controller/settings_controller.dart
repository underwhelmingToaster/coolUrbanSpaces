import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:flutter/cupertino.dart';

class SettingsController extends ChangeNotifier {
  SortingTypes _browsingSort = SortingTypes.NAME;
  bool _exampleSwitch = true;

  bool get exampleSwitch => _exampleSwitch;

  set exampleSwitch(bool value) {
    _exampleSwitch = value;
    notifyListeners();
  }

  SortingTypes get browsingSort => _browsingSort;

  set browsingSort(SortingTypes value) {
    _browsingSort = value;
    notifyListeners();
  }
}
