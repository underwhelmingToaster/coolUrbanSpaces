
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_urban_spaces/api/suggestionManager.dart';

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
    var selectedSuggestion;
    if(_id>=0){
      selectedSuggestion = SuggestionManager.getSuggestion(_id);
    }

    return Visibility(
        visible: selectedSuggestion!=null,
        child: Scaffold(
            appBar: AppBar(
              title: Text(selectedSuggestion.title),
            ) ,
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
