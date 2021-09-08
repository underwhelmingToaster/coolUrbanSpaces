
import 'package:cool_urban_spaces/Controller/markerController.dart';
import 'package:cool_urban_spaces/Model/suggestion.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_urban_spaces/api/suggestionManager.dart';
import 'package:provider/provider.dart';

class StatefulViewSuggestionFragment extends StatefulWidget {

  StatefulViewSuggestionFragment(this.id);
  int id;
  @override
  _ViewSuggestionFragment createState() => _ViewSuggestionFragment(id);
}

class _ViewSuggestionFragment extends State<StatefulViewSuggestionFragment> {

  int _id;

  _ViewSuggestionFragment(this._id);

  @override
  Widget build(BuildContext context) {
    MarkerController controller = Provider.of<MarkerController>(context);
    if(_id>=0){
      SuggestionManager.getSuggestion(_id).then((value) =>
      {
        controller.selectedMarker = value
      });
    }

    bool isNull = controller.SelectedSuggestion != null;

    return Visibility(
        visible: isNull,
        child: Scaffold(
            appBar: AppBar(
              title: controller.SelectedSuggestion != null ? Text(controller.SelectedSuggestion!.title) : Text(""),
            ),
            body: Padding(padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget> [
                    Text("lol"),
                  ],
                )
            )
        )
    );
  }
}
