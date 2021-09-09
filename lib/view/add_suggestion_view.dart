

import 'package:cool_urban_spaces/Api/suggestionManager.dart';
import 'package:cool_urban_spaces/Model/suggestion.dart';
import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AddSuggestionView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    AddSuggestionController suggestionController = Provider.of<AddSuggestionController>(context);
    MapDataController mapDataController = Provider.of<MapDataController>(context);
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Add a suggestion"),
          ),
          body: Padding(padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "A short title"
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(50)],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please add a title";
                    }
                    return null;
                    },
                  onChanged: (v) => suggestionController.title = v,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      labelText: "Description",
                      hintText: "Describe your suggestion.dart in more detail"
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
                Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                  child: Text("Type of Suggestion:")
                ),
                DropdownButton(
                  value: suggestionController.type,
                  isExpanded: true,
                  items: [
                  DropdownMenuItem(
                    child: Text("General"), value: 0),
                  DropdownMenuItem(
                    child: Text("Shading"), value: 1),
                  DropdownMenuItem(
                    child: Text("Seating"), value: 2),
                  DropdownMenuItem(
                    child: Text("Gardening"), value: 3),
                  DropdownMenuItem(
                    child: Text("Social"), value: 4),
                  DropdownMenuItem(
                    child: Text("Water"), value: 5),
                  DropdownMenuItem(
                    child: Text("Plants"), value: 6),
                  ],
                  onChanged: (v) => suggestionController.type = (v as int),
                ),
                Padding(padding: EdgeInsets.all(30),
                  child: ElevatedButton(
                    onPressed: () {
                        if(suggestionController.submit((c) => SuggestionManager.formatSuggestions().then((value) => mapDataController.setMarkerDataList(value)))) {
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Processing Data')));
                          Navigator.pop(context);
                        }else{
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Missing Data'), backgroundColor: Colors.red));
                        }
                      },
                    child: const Text('Submit'),
                  ),
                )
              ],
            ),
          ),
        )
    );
  }
}
