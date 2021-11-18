import 'package:cool_urban_spaces/data/abstract_data.dart';
import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/urban_map_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

/// Is the Provider Class which is responsible for the data used in [UrbanMapView]
class MapDataController extends ChangeNotifier {
  List<Marker> _availableMarkers = [];
  List<SuggestionModel> _cachedSuggestions = [];
  List<SuggestionModel> _supportedSuggestions = [];

  SuggestionModel? _lastSelect;

  List<SuggestionModel> get cachedSuggestions => _cachedSuggestions;

  List<SuggestionModel> get supportedSuggestions => _supportedSuggestions;

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

  /// returns a sorted list of suggestions
  List<SuggestionModel> getSortedSuggestions(SortingTypes sortType) {
    List<SuggestionModel> suggestions = _cachedSuggestions;

    switch (sortType) {
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

  /// Converts [key] into an [int]
  int cleanUpKey(Key key) {
    return int.parse(
        key.toString().replaceAll("[<'", "").replaceAll("'>]", ""));
  }

  /// Requests all suggestions from [DataProvider] and asynchronously adds them to the map data.
  /// Notifies listeners
  void updateMarkers() {
    Future<List<SuggestionModel>> suggestions =
        DataProvider.dataProvider.getAllSuggestions();
    Stream<List<Marker>> updatedMarkers =
        Stream.fromFuture(suggestions).asyncMap<List<Marker>>(
      (suggestionList) => Future.wait(
        suggestionList.map<Future<Marker>>((e) async => suggestionToMarkers(e)),
      ),
    );
    updatedMarkers
        .forEach((element) => {availableMarkers = element, notifyListeners()});

    suggestions.then((value) => _cachedSuggestions = value);
    notifyListeners();
    //_updateSupported(0); //TODO: <-- get userID somehow? User needs a big refactor.
  }

  /// writes the [SuggestionModel] with the id [id] into [_lastSelect]
  void setSelectedMarkerToId(int id) {
    DataProvider.dataProvider.getSuggestion(id).then((value) => {
          _lastSelect = value,
        });
  }

  /// Converts [SuggestionModel] into [Marker].
  Marker suggestionToMarkers(SuggestionModel suggestion) {
    Widget icon = SvgPicture.asset("icons/shade.svg");
    icon = suggestion.getMarkerIcon();

    return new Marker(
        width: 80.0,
        height: 80.0,
        point: LatLng(suggestion.lat, suggestion.lng),
        builder: (ctx) => Container(child: icon),
        key: new Key(suggestion.id.toString()));
  }

  /// Adds a new suggestion to the local cache and writes it to db via [DataProvider]
  void addSuggestion(SuggestionModel suggestion) {
    _availableMarkers.add(suggestionToMarkers(suggestion));
    DataProvider.dataProvider.postSuggestion(suggestion);
    updateMarkers();
  }

  void _updateSupported(int userID) {
    _supportedSuggestions.clear();
    DataProvider.dataProvider.getSupported(userID).then((value) => {
      //TODO: check if is supported

        });
  }

  /// Adds [suggestionModel] to the list of supported [SuggestionModel]s
  void support(int userId, SuggestionModel suggestionModel) {
    DataProvider.dataProvider.postSupport(userId, suggestionModel.id as int);
    _supportedSuggestions.add(suggestionModel);
   //_updateSupported(0); //TODO: GET USERID
    notifyListeners();
  }

  /// Returns true when [suggestionModel] is supported by the user with the id [userId]
  bool doesSupport(int userId, SuggestionModel suggestionModel) {
    return _supportedSuggestions.contains(suggestionModel);
  }


  /// Removes [supportedSuggestions] of the list of supported [SuggestionModel]s
  void stopSupporting(int userId, SuggestionModel suggestionModel){
    DataProvider.dataProvider.deleteSupport(userId, suggestionModel.id as int);
    _supportedSuggestions.remove(suggestionModel);
    notifyListeners();
  }
}
