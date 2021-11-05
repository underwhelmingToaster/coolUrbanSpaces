import 'package:flutter/cupertino.dart';

class AddSuggestionController extends ChangeNotifier {
  String _title = "";
  String _desc = "";
  int _type = 1;
  double _lat = 0;
  double _lon = 0;

  bool submit() {
    if (title.isNotEmpty && desc.isNotEmpty) {
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

  void setLocation(double lat, double lon){
    this.lat = lat;
    this.lon = lon;
    notifyListeners();
  }
}