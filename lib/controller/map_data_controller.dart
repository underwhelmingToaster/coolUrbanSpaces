


import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_map/flutter_map.dart';

class MapDataController extends ChangeNotifier{
  Map<int, Marker> _availableMarkers = new Map();


  void addMarker(Marker marker){
    _availableMarkers[cleanUpKey(marker.key as Key)] = marker;
    notifyListeners();
  }

  void setMarkerDataList(List<Marker> markerList){
    _availableMarkers.clear();
    markerList.forEach((element) {
      _availableMarkers[cleanUpKey(element.key as Key)] = element;
    });
    notifyListeners();
  }

  void setMarkerDataMap(Map<int, Marker> markerMap){
    _availableMarkers = markerMap;
    notifyListeners();
  }

  int cleanUpKey(Key key){
    return int.parse(key.toString().replaceAll("[<'", "").replaceAll("'>]", ""));
  }

  List<Marker> getAvailableAsList(){
    List<Marker> resultList = [];
    _availableMarkers.forEach((key, value) => resultList.add(value));
    return resultList;
  }
}