import 'package:flutter/cupertino.dart';

class TutorialController extends ChangeNotifier{
  bool _showCreateNotice = true;

  bool get showCreateNotice {
    return _showCreateNotice;
  }

  void set showCreateNotice(bool show){
    _showCreateNotice = show;
    notifyListeners();
  }
}