
import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MarkerController extends ChangeNotifier {
  List<Marker> _markerList = [];

  set markerList(List<Marker> markerList){
    _markerList = markerList;
    notifyListeners();
  }

  void addMarker(Marker marker){
    _markerList.add(marker);
    notifyListeners();
  }

  List<Marker> get markerList => _markerList;
}