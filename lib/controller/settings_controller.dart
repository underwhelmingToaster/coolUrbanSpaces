import 'package:flutter/cupertino.dart';

class SettingsController extends ChangeNotifier{

  bool stopAsyncTask = false;
  bool restartAsyncTask = false;

  String _browsingSort = "Name";
  bool _exampleSwitch = true;
  bool _automaticChatRefresh = false;
  int _chatRefreshRate = 20;


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

  bool get automaticRefresh => _automaticChatRefresh;

  set automaticRefresh(bool value) {
    _automaticChatRefresh = value;
    if(value){
      restartAsyncTask = true;
    }else{
      stopAsyncTask = true;
    }
    notifyListeners();
  }

  int get chatRefreshRate => _chatRefreshRate;

  set chatRefreshRate(int value) {
    _chatRefreshRate = value;
    restartAsyncTask = true;
    notifyListeners();
  }


}