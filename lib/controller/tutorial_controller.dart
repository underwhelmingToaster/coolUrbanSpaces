import 'package:flutter/cupertino.dart';

class TutorialController extends ChangeNotifier{
  bool _showCreateNotice = true;
  int _menuCounter = 3;
  int _addSuggestionCounter = 3;


  bool get showCreateNotice {
    return _showCreateNotice;
  }

  set showCreateNotice(bool show){
    _showCreateNotice = show;
    notifyListeners();
  }

  int get menuCounter {
    return _menuCounter;
  }

  set menuCounter(int count){
    _menuCounter = count;
    notifyListeners();
  }

  int get addSuggestionCounter{
    return _addSuggestionCounter;
  }

  set addSuggestionCounter(int count){
    _addSuggestionCounter = count;
    notifyListeners();
  }


}