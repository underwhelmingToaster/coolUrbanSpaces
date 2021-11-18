import 'package:cool_urban_spaces/controller/add_suggestion_controller.dart';
import 'package:cool_urban_spaces/controller/enum/suggestion_type.dart';
import 'package:cool_urban_spaces/controller/map_data_controller.dart';
import 'package:cool_urban_spaces/controller/tutorial_controller.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/view/widgets/urban_map_widget.dart';
import 'package:cool_urban_spaces/view/widgets/utils_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:provider/provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:simple_tooltip/simple_tooltip.dart';

class AddSuggestionView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AddSuggestionController suggestionController =
        Provider.of<AddSuggestionController>(context);
    MapDataController mapDataController =
        Provider.of<MapDataController>(context);

    TutorialController tutorialController = Provider.of<TutorialController>(context);

    LatLng startPosition =
        LatLng(suggestionController.lat, suggestionController.lon);

    List<Marker> markList = [];
    markList.add(
      new Marker(
        point: startPosition,
        builder: (ctx) => Container(
          child: Icon(
            Icons.add_location,
            color: Colors.red,
          ),
        ),
      ),
    );

    List<DropdownMenuItem<int>> dropdown = [];
    SuggestionTypes.values.forEach((element) {
      dropdown.add(
          new DropdownMenuItem<int>(
            child: Text(SuggestionType.enumToString(element)),
            value: element.index,
          )
      );
    });

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("Add a suggestion"),
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
                child: Container(
                  child: UrbanMapView(
                    displayedMarkers: markList,
                    isInteractable: false,
                    startZoom: 18,
                    startLocation: startPosition,
                  ),
                  height: 100,
                )
            ),
            NormalizedPadding(
                child: Align(child: Text("Type of Suggestion:"), alignment: Alignment.topLeft,)),
            NormalizedPadding(
              child: ToolTip(
                child: DropdownButton<int>(
                  value: suggestionController.type,
                  isExpanded: true,
                  items: dropdown,
                  onChanged: (v)  {
                    suggestionController.type = (v as int);
                    if(tutorialController.addSuggestionCounter == 99){
                      tutorialController.addSuggestionCounter = 2;
                    }
                  },
                  onTap: () { if(tutorialController.addSuggestionCounter == 3){
                    tutorialController.addSuggestionCounter = 99;
                  }
                  },
                ),
                text: "First of all select a fitting category for your suggestion.",
                fontSize: 15,
                show: tutorialController.addSuggestionCounter == 3,
                direction: TooltipDirection.down,
                onTap: () => tutorialController.addSuggestionCounter--,
              )
            ),
            NormalizedPadding(
              child: ToolTip(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Describe your suggestion in more detail",
                    labelStyle: new TextStyle(color: Theme.of(context).primaryColor),
                  ),
                  inputFormatters: [LengthLimitingTextInputFormatter(500)],
                  minLines: 1,
                  maxLines: 10,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please describe your project";
                    }
                    return null;
                  },
                  onEditingComplete: () {
                    if(tutorialController.addSuggestionCounter == 2){
                      tutorialController.addSuggestionCounter--;
                    }
                  },
                  onChanged: (v) {
                    suggestionController.desc = v;
                  },
                ),
                text: "Explain your idea in more detail, so people can better understand what you're suggesting. [Click me]",
                fontSize: 15,
                show: tutorialController.addSuggestionCounter == 2,
                direction: TooltipDirection.up,
                onTap: () => tutorialController.addSuggestionCounter--,
              )
            ),
            NormalizedPadding(
             child: ToolTip(
               child: TextFormField(
                 decoration: InputDecoration(
                     labelText: "Title",
                     hintText: "A short title",
                     labelStyle: new TextStyle(color: Theme.of(context).primaryColor)),
                 inputFormatters: [LengthLimitingTextInputFormatter(50)],
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return "Please add a title";
                   }
                   return null;
                   },
                   onEditingComplete: () {
                     if(tutorialController.addSuggestionCounter == 1){
                       tutorialController.addSuggestionCounter--;
                     }
                   },
                 onChanged: (v) {
                   suggestionController.title = v;
                 }
                 ),
               text: "[Optional] If you want you can give your suggestion a title. (This will help people to find your suggestion) If you're happy with the result you can click on 'Submit'.",
               fontSize: 15,
               show: tutorialController.addSuggestionCounter == 1,
               direction: TooltipDirection.up,
               onTap: () => tutorialController.addSuggestionCounter--,
             )
            ),
            NormalizedPadding(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor,
                ),
                onPressed: () {
                  if (suggestionController.submit()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')));
                    Navigator.pop(context);
                    SuggestionModel suggestion = new SuggestionModel(
                        suggestionController.title,
                        suggestionController.desc,
                        suggestionController.type,
                        suggestionController.lat,
                        suggestionController.lon);
                    mapDataController.addSuggestion(suggestion);
                    suggestionController.reset();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please provide a short description'),
                        backgroundColor: Colors.red));
                  }
                  tutorialController.addSuggestionCounter = 0;
                  },
                child: const Text('Submit'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
