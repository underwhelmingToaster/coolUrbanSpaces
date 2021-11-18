import 'package:cool_urban_spaces/controller/enum/suggestion_type.dart';
import 'package:cool_urban_spaces/view/add_suggestion_view.dart';
import 'package:flutter/cupertino.dart';

/// Is the Provider Class which is responsible for the suggestion From in [AddSuggestionView]
class AddSuggestionController extends ChangeNotifier {
  String _title = "";
  String _desc = "";
  int _type = 1;
  double _lat = 0;
  double _lon = 0;

  /// validates form in [AddSuggestionView]
  bool submit() {
    if (desc.isNotEmpty) {
      if(title.isEmpty){
        title = SuggestionType.intToString(type);
      }
      return true;
    }
    return false;
  }

  /// resets all values to it's default state
  void reset() {
    title = "";
    desc = "";
    type = 1;
    lat = 0;
    lon = 0;
  }

  /// sets [_lat] and [_lon] in the current form and notifies listeners
  void setLocation(double lat, double lon) {
    this.lat = lat;
    this.lon = lon;
    notifyListeners();
  }

  /// returns [_lon]
  double get lon => _lon;

  /// sets [_lon] in location and notifies listeners
  set lon(double value) {
    _lon = value;
    notifyListeners();
  }

  /// returns [_title]
  String get title => _title;

  /// sets [_title] and notifies listeners
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  /// return [_lat]
  double get lat => _lat;

  /// sets [_lat] and notifies listeners
  set lat(double value) {
    _lat = value;
    notifyListeners();
  }

  /// returns [_desc]
  String get desc => _desc;

  /// sets [_desc] and notifies listeners
  set desc(String value) {
    _desc = value;
    notifyListeners();
  }

  /// returns [_type]
  int get type => _type;

  /// sets [_type] and notifies listeners
  set type(int value) {
    _type = value;
    notifyListeners();
  }
}
