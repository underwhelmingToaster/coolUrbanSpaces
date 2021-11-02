import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/utils_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowsingView extends StatelessWidget{

  final List<String> sortOptions = ["Id", "Name", "Type"]; // TODO change to enum?


  @override
  Widget build(BuildContext context) {
    MapDataController dataController = Provider.of<MapDataController>(context);
    SettingsController settingsController = Provider.of<SettingsController>(context);
    List<Widget> widgets = [];

    List<SuggestionModel> suggestions = dataController.cachedSuggestions;

    switch(settingsController.browsingSort){
      case "Name":
        suggestions.sort((a, b) => a.text.compareTo(b.text));
        break;

      case "Id":
        suggestions.sort((a, b) => a.id!.compareTo(b.id!));
        break;

      case "Type":
        suggestions.sort((a, b) => a.type.compareTo(b.type));
        break;

      default:
        throw new UnsupportedError("Don't recognize type :" + settingsController.browsingSort);
    }


    suggestions.forEach((suggestion) {
      widgets.add(new Card(
          child: ListTile(
            title: Text(suggestion.title),
            trailing: dataController.getMarkerIcon(suggestion),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(suggestion.text),
              ],
            ),
          ),
      ));
    });

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text("Browse"),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          body: Column(
            children: [
              NormalizedPadding(
                child: Row(
                  children: [
                    Text("All Entries:"),
                    Spacer(),
                    DropdownButton(
                      value: settingsController.browsingSort,
                      onChanged: (String? newValue) {
                        settingsController.browsingSort = newValue!;
                      },
                      items: sortOptions.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                    children: widgets,
                  )
              ),
            ],
          ),
        )
    );
  }
}