import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:http/http.dart' as http;

class SuggestionManager {
  Future<List<Suggestion>> getAllSugestions() async{
    final response = await http.get(Uri.parse('/api/suggestion'));

    if(response.statusCode == 200) {
      List<Suggestion> suggestions = [];
      Map<String, dynamic> json = jsonDecode(response.body);
      List<dynamic> suggestionList = json['suggestions'];
      suggestionList.forEach((element) {
        suggestions.add(element);
      });

      return suggestions;
    }else{
      throw Exception('Failed to load suggestions');
    }
  }

  Future<Suggestion> getSuggestion(int id) async{
    final response = await http.get(Uri.parse('/api/suggestion/' + id.toString()));
    if(response.statusCode == 200){
      return Suggestion.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load suggestion');
    }
  }

  void postSuggestion(Suggestion suggestion){
    http.post(Uri.parse('/api/suggestion/'), body: suggestion);
  }

  Future<List<Marker>> formatSuggestions() async{
    List<Marker> markers = [];
    List<Suggestion> suggestions = await getAllSugestions();

    for (int i = 0; i < suggestions.length; i++){
      Widget icon = SvgPicture.asset("icons/shade.svg");
      switch(suggestions[i].type) {
        case 1: icon = SvgPicture.asset("../icons/shade.svg"); break;
        case 2: icon = SvgPicture.asset("../icons/seating.svg"); break;
        case 3: icon = SvgPicture.asset("../icons/gardening.svg"); break;
        case 4: icon = SvgPicture.asset("../icons/social.svg"); break;
        case 5: icon = SvgPicture.asset("../icons/water.svg"); break;
        case 6: icon = SvgPicture.asset("../icons/plants.svg"); break;
        case 7: icon = SvgPicture.asset("../icons/general.svg"); break;
        default: print("Could not assign type of suggestion.dart");
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


