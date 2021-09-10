import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';

class InfoSuggestionView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    String title = "";
    String desc = "";
    MapDataController mapDataController = Provider.of<MapDataController>(context);
    Suggestion? suggestion= mapDataController.lastSelect;
    if(suggestion!=null){
      title = suggestion.title;
      desc = suggestion.text;
    }

    List<Widget> displayList = [];
    // TODO: Get Comments and fill into list with colored seperators inbetween

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Column(children: <Widget>[
            Row(children: [
              Text("ADRESS?"),
              Spacer(flex: 1,),
              Text(desc),
            ],),
            Expanded(child:
            ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text("Current situation"),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text("Suggestions"),
                  ),
                )
              ],
            ),)
          ],)
        )
    );
  }
}