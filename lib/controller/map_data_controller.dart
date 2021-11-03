import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class MapDataController extends ChangeNotifier {
  List<Marker> _availableMarkers = [];
  List<SuggestionModel> _cachedSuggestions = [];

  SuggestionModel? _lastSelect;

  List<SuggestionModel> get cachedSuggestions => _cachedSuggestions;

  SuggestionModel? get lastSelect => _lastSelect;

  set lastSelect(SuggestionModel? value) {
    _lastSelect = value;
    notifyListeners();
  }

  set availableMarkers(List<Marker> value) {
    _availableMarkers = value;
    notifyListeners();
  }

  List<Marker> get availableMarkers => _availableMarkers;

  List<SuggestionModel> getSortedSuggestions(SortingTypes sortType){
    List<SuggestionModel> suggestions = _cachedSuggestions;

    switch(sortType) {
      case SortingTypes.NAME:
        suggestions.sort((a, b) => a.text.compareTo(b.text));
        break;

      case SortingTypes.ID:
        suggestions.sort((a, b) => a.id!.compareTo(b.id!));
        break;

      case SortingTypes.TYPE:
        suggestions.sort((a, b) => a.type.compareTo(b.type));
        break;

      default:
        throw new UnsupportedError("Don't recognize SortingType");
    }

    return suggestions;
  }

  int cleanUpKey(Key key) {
    return int.parse(
        key.toString().replaceAll("[<'", "").replaceAll("'>]", ""));
  }

  void updateMarkers(){
    Future<List<SuggestionModel>> suggestions = DataProvider.dataProvider.getAllSuggestions();
    Stream<List<Marker>> updatedMarkers = Stream.fromFuture(suggestions)
        .asyncMap<List<Marker>>((suggestionList) => Future.wait(
          suggestionList.map<Future<Marker>>((e) async => suggestionToMarkers(e)
          ),
        ),
      );
    updatedMarkers.forEach((element) => {
      availableMarkers = element,
      notifyListeners()
    });

    suggestions.then((value) => _cachedSuggestions = value);
    notifyListeners();
  }


  void setSelectedMarkerToId(int id){
    DataProvider.dataProvider.getSuggestion(id).then((value) => {
      _lastSelect = value,
    });
  }

  Marker suggestionToMarkers(SuggestionModel suggestion) {
    Widget icon = SvgPicture.asset("icons/shade.svg");
    icon = getMarkerIcon(suggestion);

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

  Icon getMarkerIcon(SuggestionModel suggestion){
    switch (suggestion.type) {
      case 0:
        return Icon(Icons.pin_drop, color: Colors.amber);
      case 1:
        return Icon(Icons.wb_sunny_outlined, color: Colors.yellow);
      case 2:
        return Icon(Icons.event_seat_outlined, color: Colors.grey);
      case 3:
        return Icon(Icons.local_florist_outlined, color: Colors.green);
      case 4:
        return Icon(Icons.person_outline, color: Colors.orange);
      case 5:
        return Icon(Icons.waves_outlined, color: Colors.blue);
      case 6:
        return Icon(Icons.account_tree_outlined, color: Colors.green);
      case 7:
        return Icon(Icons.lightbulb_outline, color: Colors.yellow);
      default:
        print("Could not assign type of suggestion.dart");
        return Icon(Icons.warning, color: Colors.red);
    }
  }

  void addSuggestion(SuggestionModel suggestion){
    _availableMarkers.add(suggestionToMarkers(suggestion));
    DataProvider.dataProvider.postSuggestion(suggestion);
    updateMarkers();
  }
}
