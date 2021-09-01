import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';

class SuggestionManager {
  List getSuggestions () {
    var suggestion1 = new Suggestion("titel 1", "text 1", 1, 51.1, -0.09);
    var suggestion2 = new Suggestion("titel 2", "text 2", 2, 51.2, -0.07);
    var suggestions = [suggestion1, suggestion2];
    return suggestions;
  }

  List getExampleSuggestions () {
    var suggestion1 = new Suggestion("titel 1", "text 1", 1, 51.1, -0.09);
    var suggestion2 = new Suggestion("titel 2", "text 2", 2, 51.2, -0.07);
    var suggestions = [suggestion1, suggestion2];
    return suggestions;
  }

  List<Marker> formatSuggestions () {
    List<Marker> markers = [];
    var suggestions = getSuggestions();
    for (int i = 0; i < suggestions.length; i++){
      Widget icon = SvgPicture.asset("icons/shade.svg");
      switch(suggestions[i].type) {
        case 1: icon = SvgPicture.asset("../icons/shade.svg"); break;
        case 2: icon = SvgPicture.asset("../icons/seating.svg"); break;
        case 3: icon = SvgPicture.asset("../icons/gardening.svg"); break;
        case 4: icon = SvgPicture.asset("../icons/social.svg"); break;
        case 5: icon = SvgPicture.asset("../icons/water.svg"); break;
        case 6: icon = SvgPicture.asset("../icons/plants.svg"); break;
        case 0: icon = SvgPicture.asset("../icons/general.svg"); break;
        default: print("Could not assign type of suggestion");
      }
      markers.add(
          Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(suggestions[i].lat, suggestions[i].lng),
            builder: (ctx) =>
                Container(
                    child: Icon(Icons.location_pin) // TODO get icons to work?
                ))
          );
    }
    return markers;
  }

}

class Suggestion {

  late String title;
  late String text;
  late int type;
  late double lat;
  late double lng;

  Suggestion(this.title, this.text, this.type, this.lat, this.lng);


}