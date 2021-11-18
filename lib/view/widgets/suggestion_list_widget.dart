import 'package:cool_urban_spaces/controller/enum/sorting_type.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Provides a list that can hold [SuggestionModel]
class SuggestionList extends StatelessWidget {
  late final List<SuggestionModel> suggestions;
  final Function? onTab;

  SuggestionList({required this.suggestions, this.onTab});

  @override
  Widget build(BuildContext context) {
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    List<Widget> widgets = [];

    suggestions.forEach((suggestion) {
      widgets.add(new Card(
        child: ListTile(
          onTap: () {
            if (onTab != null) {
              onTab!(suggestion);
            }
          },
          title: Text(suggestion.title),
          trailing: suggestion.getMarkerIcon(),
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
              Spacer(),
              Align(child: Text("Order by: "), alignment: Alignment.centerRight,),
              DropdownButton(
                value:
                    SortingType.enumToString(settingsController.browsingSort),
                onChanged: (String? newValue) {
                  settingsController.browsingSort =
                      SortingType.stringToEnum(newValue!);
                },
                items: SortingType.sortingTypesStringList()
                    .map<DropdownMenuItem<String>>((String value) {
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
        )),
      ],
    );
  }
}
