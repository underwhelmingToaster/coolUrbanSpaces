import 'package:cool_urban_spaces/Controller/markerController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_urban_spaces/api/suggestionManager.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class StatefulViewSuggestionFragment extends StatefulWidget {
  @override
  _ViewSuggestionFragment createState() => _ViewSuggestionFragment();
}

class _ViewSuggestionFragment extends State<StatefulViewSuggestionFragment> {

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<MarkerController>(context);
    var selectedSuggestion;
    SuggestionManager.getAllSuggestions().then((value) => {
      value.forEach((element) {
        var pos = new LatLng(element.lat, element.lng);
        if(pos.latitude == element.lat && pos.longitude == element.lng){
          int id = 0;
          if(element.id!=null){
            id = (element.id) as int;
          }
           // TODO hilfe ka wie
          selectedSuggestion = SuggestionManager.getSuggestion(id) as Suggestion;
          return;

        }
      })
    });
    return Visibility(
        visible: selectedSuggestion!=null,
        child: Scaffold(
        appBar: AppBar(
          title: Text(selectedSuggestion.title),
        ) ,
        body: Padding(padding: EdgeInsets.all(10) ,
            child: Column(
              children: <Widget> [
                Text("lol"),
              ],
            )
        )
      )
    );
  }

}
