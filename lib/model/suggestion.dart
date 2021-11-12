import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SuggestionModel {
  int? id;
  late String title;
  late String text;
  late int type;
  late double lat;
  late double lng;

  SuggestionModel(this.title, this.text, this.type, this.lat, this.lng,
      [this.id]);

  SuggestionModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        text = json['description'],
        type = json['type'],
        lat = json['lat'],
        lng = json['lon'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': text,
        'type': type,
        'lat': lat,
        'lon': lng,
      };

  Icon getMarkerIcon() {
    //FIXME: is it better if the Icon itself gets stored in model?
    switch (this.type) {
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
}
