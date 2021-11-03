import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/utils_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrowsingView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    MapDataController dataController = Provider.of<MapDataController>(context);
    SettingsController settingsController = Provider.of<SettingsController>(context);

    List<SuggestionModel> suggestions = dataController.cachedSuggestions;

    List<Widget> widgets = [];

    suggestions = dataController.getSortedSuggestions(settingsController.browsingSort);


    suggestions.forEach((suggestion) {
      widgets.add(new Card(
          child: ListTile(
            onTap: () {
              //TODO: open info_suggestion_view for *suggestion*
            },
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
                      value: SortingType.enumToString(settingsController.browsingSort),
                      onChanged: (String? newValue) {
                        settingsController.browsingSort = SortingType.stringToEnum(newValue!);
                      },
                      items: SortingType.sortingTypesStringList().map<DropdownMenuItem<String>>((String value) {
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