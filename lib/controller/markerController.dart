
import 'package:cool_urban_spaces/Model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MarkerController extends ChangeNotifier {
  List<Marker> _markerList = [];

  Suggestion? _selectedSuggester;

  set markerList(List<Marker> markerList){
    _markerList = markerList;
    notifyListeners();
  }

  set selectedMarker(Suggestion? marker){
    _selectedSuggester = marker;
    notifyListeners();
  }

  Suggestion? get SelectedSuggestion => _selectedSuggester;

  void addMarker(Marker marker){
    _markerList.add(marker);
    notifyListeners();
  }

  List<Marker> get markerList => _markerList;
}