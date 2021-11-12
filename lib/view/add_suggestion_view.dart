import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/urban_map_widget.dart';
import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';

class AddSuggestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddSuggestionController suggestionController =
        Provider.of<AddSuggestionController>(context);
    MapDataController mapDataController =
        Provider.of<MapDataController>(context);

    LatLng startPosition =
        LatLng(suggestionController.lat, suggestionController.lon);

    List<Marker> markList = [];
    markList.add(
      new Marker(
        point: startPosition,
        builder: (ctx) => Container(
          child: Icon(
            Icons.add_location,
            color: Colors.red,
          ),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Add a suggestion"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  child: UrbanMapView(
                    displayedMarkers: markList,
                    isInteractable: false,
                    startZoom: 15,
                    startLocation: startPosition,
                  ),
                  height: 100,
                )
            ),
            NormalizedPadding(
             child: TextFormField(
               decoration: InputDecoration(
                   labelText: "Title",
                   hintText: "A short title",
                   labelStyle: new TextStyle(color: Theme.of(context).primaryColor)),
               inputFormatters: [LengthLimitingTextInputFormatter(50)],
               validator: (value) {
                 if (value == null || value.isEmpty) {
                   return "Please add a title";
                 }
                 return null;
               },
               onChanged: (v) => suggestionController.title = v,
             ),
            ),
            NormalizedPadding(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Description",
                  hintText: "Describe your suggestion.dart in more detail",
                  labelStyle: new TextStyle(color: Theme.of(context).primaryColor),
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(500)],
                minLines: 4,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please describe your project";
                  }
                  return null;
                },
                onChanged: (v) => suggestionController.desc = v,
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Text("Type of Suggestion:")),
            NormalizedPadding(
              child: DropdownButton(
                value: suggestionController.type,
                isExpanded: true,
                items: [
                  DropdownMenuItem(child: Text("General"), value: 0),
                  DropdownMenuItem(child: Text("Shading"), value: 1),
                  DropdownMenuItem(child: Text("Seating"), value: 2),
                  DropdownMenuItem(child: Text("Gardening"), value: 3),
                  DropdownMenuItem(child: Text("Social"), value: 4),
                  DropdownMenuItem(child: Text("Water"), value: 5),
                  DropdownMenuItem(child: Text("Plants"), value: 6),
                ],
                onChanged: (v) => suggestionController.type = (v as int),
              ),
            ),
            NormalizedPadding(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  if (suggestionController.submit()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')));
                    Navigator.pop(context);
                    SuggestionModel suggestion = new SuggestionModel(
                        suggestionController.title,
                        suggestionController.desc,
                        suggestionController.type,
                        suggestionController.lat,
                        suggestionController.lon);
                    mapDataController.addSuggestion(suggestion);
                    suggestionController.reset();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Missing Data'),
                        backgroundColor: Colors.red));
                  }
                },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
