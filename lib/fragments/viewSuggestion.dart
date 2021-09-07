import 'package:cool_urban_spaces/Controller/markerController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_urban_spaces/api/suggestionManager.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';

class StatefulViewSuggestionFragment extends StatefulWidget {

  StatefulViewSuggestionFragment(this.id);
  int id;
  @override
  _ViewSuggestionFragment createState() => _ViewSuggestionFragment(id);
}

class _ViewSuggestionFragment extends State<StatefulViewSuggestionFragment> {

  int id;
  _ViewSuggestionFragment(this.id);

  @override
  Widget build(BuildContext context) {
    var selectedSuggestion;
    Marker? selected = Provider.of<MarkerController>(context).selectedMarker;
    if(selected!=null){
      selectedSuggestion = SuggestionManager.getSuggestion(selected.key as int);
    }

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
