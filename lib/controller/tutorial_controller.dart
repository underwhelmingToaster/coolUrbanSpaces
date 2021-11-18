import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TutorialController extends ChangeNotifier{

  bool doneTutorial = false;
  String _key = "done_tutorial";
  bool initialCheck = true;

  TutorialController(){
    if(initialCheck){
      checkStorage();
      initialCheck = false;
    }
  }

  bool _showCreateNotice = true;
  int _menuCounter = 3;
  int _addSuggestionCounter = 3;
  bool _showBackBrowseMessage = true;
  bool _showBackSupportMessage = true;

  bool get showBackSupportMessage{
    return _showBackSupportMessage;
  }

  set showBackSupportMessage(bool show){
    _showBackSupportMessage = show;
    notifyListeners();
  }


  bool get showBackBrowseMessage {
    return _showBackBrowseMessage;
  }

  set showBackBrowseMessage(bool show) {
    _showBackBrowseMessage = show;
    notifyListeners();
  }

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
    writeTutorial(doneTutorial);
    notifyListeners();
  }

  int get addSuggestionCounter{
    return _addSuggestionCounter;
  }

  set addSuggestionCounter(int count){
    _addSuggestionCounter = count;
    notifyListeners();
  }

  void resetState(){
    _showBackBrowseMessage = true;
    _showCreateNotice = true;
    _menuCounter = 3;
    _addSuggestionCounter = 3;
    notifyListeners();
  }

  void deactivateAll(){
    _showBackSupportMessage = false;
    _showCreateNotice = false;
    _menuCounter = 0;
    _addSuggestionCounter = 0;
    SharedPreferences.getInstance().then((value) => value.setBool(_key, false));
    notifyListeners();
  }

  void checkStorage() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    doneTutorial = prefs.getBool('done_tutorial') ?? false;
    if(doneTutorial){
      deactivateAll();
    }else{
      resetState();
    }
  }

  void writeTutorial(bool done) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, done);
  }
}