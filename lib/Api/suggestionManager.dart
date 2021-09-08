import 'dart:convert';

import 'package:cool_urban_spaces/Model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/svg.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class SuggestionManager{

  static List<Suggestion> suggestionsTEMP = [];

  Future<List<Suggestion>> updateSuggestions() async{
    return getAllSuggestions();
  }

  static Future<List<Suggestion>> getAllSuggestions() async{
    return suggestionsTEMP;
    //TODO: Change to productional
    final response = await http.get(Uri.parse('/Api/suggestion/all'));

    if(response.statusCode == 200) {
      List<dynamic> suggestionList = jsonDecode(response.body);
      //return suggestionList.map((dict) => Suggestion.fromJson(dict)).toList();

    }else{
      throw Exception('Failed to load all suggestions. Status: ' + response.statusCode.toString());
    }
  }

  static Future<Suggestion> getSuggestion(int id) async{
    var result;
    suggestionsTEMP.forEach((element) {
      if(element.id == id){
        result = element;
      }
    });
    return result;
    //TODO: Change to productional
    final response = await http.get(Uri.parse('/Api/suggestion/' + id.toString()));
    if(response.statusCode == 200){
      return Suggestion.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Failed to load single suggestion. Status: ' + response.statusCode.toString());
    }
  }

  static Future<void> postSuggestion(Suggestion suggestion) async {
    if(suggestion.id==null){
      suggestion.id = SuggestionManager.suggestionsTEMP.length;
    }
    SuggestionManager.suggestionsTEMP.add(suggestion);
    return;
    //TODO: Change to productional
    final response = await http.post(Uri.parse('/Api/suggestion/add'), body: jsonEncode(suggestion.toJson()), headers: {"Content-Type": "application/json"});
    if(response.statusCode == 200){
      return;
    }else{
      throw Exception('Failed to post new Suggestion. Status: ' + response.statusCode.toString());
    }
  }

  static Future<List<Marker>> formatSuggestions() async{
    List<Marker> markers = [];
    List<Suggestion> suggestions = await getAllSuggestions();

    for (int i = 0; i < suggestions.length; i++){
      Widget icon = SvgPicture.asset("icons/shade.svg");
      switch(suggestions[i].type) {
        case 1: icon = Icon(Icons.wb_sunny_outlined, color: Colors.yellow,); break;
        case 2: icon = Icon(Icons.event_seat_outlined, color: Colors.grey,); break;
        case 3: icon = Icon(Icons.local_florist_outlined, color: Colors.green,); break;
        case 4: icon = Icon(Icons.person_outline, color: Colors.orange,); break;
        case 5: icon = Icon(Icons.waves_outlined, color: Colors.blue,); break;
        case 6: icon = Icon(Icons.account_tree_outlined, color: Colors.green,); break;
        case 7: icon = Icon(Icons.lightbulb_outline, color: Colors.yellow,); break;
        default: print("Could not assign type of suggestion.dart");
      }
      markers.add(
        new Marker(
            width: 80.0,
            height: 80.0,
            point: LatLng(suggestions[i].lat, suggestions[i].lng),
            builder: (ctx) =>
                Container(
                    child: icon
                ),
            key: new Key(suggestions[i].id.toString())
        ),
      );
    }
    return markers;
  }
}


