import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class SuggestionManager {
  List getSuggestions () {
    var suggestion1 = new Suggestion("titel 1", "text 1", "type 1", 51.1, -0.09);
    var suggestion2 = new Suggestion("titel 2", "text 2", "type 2", 51.2, -0.07);
    var suggestions = [suggestion1, suggestion2];
    return suggestions;
  }

  List<Marker> formatSuggestions () {
    List<Marker> markers = [];
    var suggestions = getSuggestions();
    for (int i = 0; i < suggestions.length; i++){
      markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(suggestions[i].lat, suggestions[i].lng),
            builder: (ctx) =>
                Container(
                    child: Icon(Icons.location_pin)
                ))
          );
    }
    return markers;
  }

}

class Suggestion {

  late String title;
  late String text;
  late String type;
  late double lat;
  late double lng;

  Suggestion(this.title, this.text, this.type, this.lat, this.lng);


}