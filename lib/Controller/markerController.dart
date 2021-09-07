
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MarkerController extends ChangeNotifier {
  List<Marker> _markerList = [];

  Marker? _selectedMarker;

  set markerList(List<Marker> markerList){
    _markerList = markerList;
    notifyListeners();
  }

  set selectedMarker(Marker? marker){
    _selectedMarker = marker;
    notifyListeners();
  }

  Marker? get selectedMarker => _selectedMarker;

  void addMarker(Marker marker){
    _markerList.add(marker);
    notifyListeners();
  }

  List<Marker> get markerList => _markerList;
}