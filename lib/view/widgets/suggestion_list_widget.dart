import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../info_suggestion_view.dart';

class SuggestionList extends StatelessWidget{

  late List<SuggestionModel> suggestions;

  SuggestionList(this.suggestions);

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController = Provider.of<SettingsController>(context);
    MapDataController dataController = Provider.of<MapDataController>(context); //TODO: try to remove this from here
    List<Widget> widgets = [];

    suggestions.forEach((suggestion) {
      widgets.add(new Card(
        child: ListTile(
          onTap: () {
            dataController.setSelectedMarkerToId(suggestion.id!);
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => InfoSuggestionView()
            ));
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


    return Column(
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
    );
  }
}