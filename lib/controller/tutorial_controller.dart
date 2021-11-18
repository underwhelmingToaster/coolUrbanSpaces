import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Is the Provider Class which is responsible to handel all the "show" [bool] which are needed in [ToolTip]
class TutorialController extends ChangeNotifier{

  bool doneTutorial = false;
  String _key = "done_tutorial";

  TutorialController(){
    checkStorage();
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

  /// resets alls values in this provider to its initial state.
  void resetState(){
    _showBackBrowseMessage = true;
    _showCreateNotice = true;
    _menuCounter = 3;
    _addSuggestionCounter = 3;
    notifyListeners();
  }

  /// deactivates all the tutorials
  void deactivateAll(){
    _showBackSupportMessage = false;
    _showCreateNotice = false;
    _menuCounter = 0;
    _addSuggestionCounter = 0;
    SharedPreferences.getInstance().then((value) => value.setBool(_key, false));
    notifyListeners();
  }

  /// Checks the persistent storage if the tutorial was ever completed
  void checkStorage() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    doneTutorial = prefs.getBool('done_tutorial') ?? false;
    if(doneTutorial){
      deactivateAll();
    }else{
      resetState();
    }
  }

  /// Sets the "was the tutorial completed" [bool] in the persistent memory to a [done]
  void writeTutorial(bool done) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_key, done);
  }
}