import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/controller/tutorial_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/suggestion_list_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

import 'info_suggestion_view.dart';
import 'widgets/utils_widget.dart';

class SupportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MapDataController dataController =
        Provider.of<MapDataController>(context);
    TutorialController tutorialController =
        Provider.of<TutorialController>(context);

    List<SuggestionModel> suggestions = dataController.supportedSuggestions;
    List<Widget> widgets = [];

    suggestions.forEach((suggestion) {
      widgets.add(new Card(
        child: ListTile(
          onTap: () {},
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

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: ToolTip(
            child: Text("Supported by me"),
            text: "Here you can see all suggestions that you are currently supporting. Press on the arrow to get back to the main screen.",
            show: tutorialController.showBackSupportMessage,
            direction: TooltipDirection.down,
            onTap: () {
              tutorialController.showBackSupportMessage = false;
            },
          ),
          actions: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
          ],
        ),
        body: SuggestionList(
          suggestions: suggestions,
          onTab: (suggestion) => {
            dataController.setSelectedMarkerToId(suggestion.id!),
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => InfoSuggestionView())),
          },
        ),
      ),
    );
  }
}
