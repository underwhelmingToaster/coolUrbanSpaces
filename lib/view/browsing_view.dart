import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowsingView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    MapDataController dataController = Provider.of<MapDataController>(context);
    List<Widget> widgets = [];

    List<Suggestion> suggestions = dataController.cachedSuggestions;
    suggestions.forEach((element) {
      widgets.add(new Card(
          child: ListTile(
            title: Text(element.title),
            trailing: Text(element.text),
          )
      ));
    });


    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Browse"),
          ),
          body: ListView(
            children: widgets,
          ),
        ));
  }
}