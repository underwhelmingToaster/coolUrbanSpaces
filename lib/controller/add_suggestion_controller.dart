
import 'package:cool_urban_spaces/api/suggestionManager.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter/cupertino.dart';

class AddSuggestionController extends ChangeNotifier {
  String _title = "";
  String _desc = "";
  int _type = 1;
  double _lat = 0;
  double _lon = 0;


  bool submit([Function? whenAdded]) {
    if (title.isNotEmpty && desc.isNotEmpty) {
      Suggestion suggestion = new Suggestion(title, desc, type, lat, lon);
      SuggestionManager.postSuggestion(suggestion);
      reset();
      if(whenAdded!=null){
        whenAdded(suggestion);
      }

      return true;
    }
    return false;
  }

  void reset() {
    title = "";
    desc = "";
    type = 1;
    lat = 0;
    lon = 0;
  }

  double get lon => _lon;

  set lon(double value) {
    _lon = value;
    notifyListeners();
  }


  String get title => _title;

  set title(String value) {
    _title = value;
    notifyListeners();
  }


  double get lat => _lat;

  set lat(double value) {
    _lat = value;
    notifyListeners();
  }

  String get desc => _desc;

  set desc(String value) {
    _desc = value;
    notifyListeners();
  }

  int get type => _type;

  set type(int value) {
    _type = value;
    notifyListeners();
  }
}