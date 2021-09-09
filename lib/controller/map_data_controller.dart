import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/data/api_request_data.dart';
import 'package:cool_urban_spaces/data/local_variable_data.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapDataController extends ChangeNotifier {
  List<Marker> _availableMarkers = [];

  Marker? _lastSelect;

  Marker? get lastSelect => _lastSelect;

  set lastSelect(Marker? value) {
    _lastSelect = value;
    notifyListeners();
  }

  DataProvider _dataProvider = LocalDataProvider();

  set availableMarkers(List<Marker> value) {
    _availableMarkers = value;
    notifyListeners();
  }

  List<Marker> get availableMarkers => _availableMarkers;

  int cleanUpKey(Key key) {
    return int.parse(
        key.toString().replaceAll("[<'", "").replaceAll("'>]", ""));
  }

  void updateMarkers(){
    Stream<List<Marker>> updatedMarkers = Stream.fromFuture(_dataProvider.getAllSuggestions())
        .asyncMap<List<Marker>>((suggestionList) => Future.wait(
          suggestionList.map<Future<Marker>>((e) async => suggestionToMarkers(e)
          ),
        ),
      );
    updatedMarkers.forEach((element) => {
      availableMarkers = element,
      notifyListeners()
    });

  }

  Marker suggestionToMarkers(Suggestion suggestion) {
    Widget icon = SvgPicture.asset("icons/shade.svg");
    switch (suggestion.type) {
      case 1:
        icon = Icon(Icons.wb_sunny_outlined, color: Colors.yellow,);
        break;
      case 2:
        icon = Icon(Icons.event_seat_outlined, color: Colors.grey,);
        break;
      case 3:
        icon = Icon(Icons.local_florist_outlined, color: Colors.green,);
        break;
      case 4:
        icon = Icon(Icons.person_outline, color: Colors.orange,);
        break;
      case 5:
        icon = Icon(Icons.waves_outlined, color: Colors.blue,);
        break;
      case 6:
        icon = Icon(Icons.account_tree_outlined, color: Colors.green,);
        break;
      case 7:
        icon = Icon(Icons.lightbulb_outline, color: Colors.yellow,);
        break;
      default:
        print("Could not assign type of suggestion.dart");
    }
    return new Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(suggestion.lat, suggestion.lng),
        builder: (ctx) =>
            Container(
                child: icon
            ),
        key: new Key(suggestion.id.toString()));
  }

  void addSuggestion(Suggestion suggestion){
    _availableMarkers.add(suggestionToMarkers(suggestion));
    _dataProvider.postSuggestion(suggestion);
    updateMarkers();
  }
}
