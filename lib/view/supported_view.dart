
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/suggestion_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SupportView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    MapDataController dataController = Provider.of<MapDataController>(context);
    SettingsController settingsController = Provider.of<SettingsController>(
        context);

    List<SuggestionModel> suggestions = dataController.cachedSuggestions;
    List<Widget> widgets = [];

    suggestions = dataController.getSortedSuggestions(settingsController.browsingSort); //FIXME: only get supported suggestions (adjust data)

    suggestions.forEach((suggestion) {
      widgets.add(new Card(
        child: ListTile(
          onTap: () {},
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
            backgroundColor: Theme
                .of(context)
                .primaryColor,
            title: Text("Browse"),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            ],
          ),
          body: SuggestionList(suggestions),
        )
    );
  }
}