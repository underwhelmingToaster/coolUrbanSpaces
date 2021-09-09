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


    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(title),
          ),
          body: Padding(padding: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              Text(desc),
            ],
          ),
        ),)
    );
  }
}