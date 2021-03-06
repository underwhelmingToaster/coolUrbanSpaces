import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/settings_controller.dart';
import 'package:cool_urban_spaces/controller/tutorial_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/suggestion_list_widget.dart';
import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

import 'info_suggestion_view.dart';

/// Browse View List all currently cached Suggestions
class BrowsingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MapDataController dataController = Provider.of<MapDataController>(context);
    SettingsController settingsController =
        Provider.of<SettingsController>(context);

    TutorialController tutorialController = Provider.of<TutorialController>(context);

    List<SuggestionModel> suggestions = dataController.cachedSuggestions;

    suggestions = dataController.getSortedSuggestions(settingsController.browsingSort);

    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: ToolTip(
              child: Text("Browse"),
              text: "Here you can see all suggestions that are currently available. Press on the arrow to get back to the main screen.",
              show: tutorialController.showBackBrowseMessage,
              direction: TooltipDirection.down,
              onTap: () {
                tutorialController.showBackBrowseMessage = false;
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    print("NOT IMPLEMENTED");
                  },
                  icon: const Icon(Icons.search)),
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
        )
    );
  }
}
