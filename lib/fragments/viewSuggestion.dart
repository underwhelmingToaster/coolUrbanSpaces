import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cool_urban_spaces/api/suggestionManager.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';

class StatefulViewSuggestionFragment extends StatefulWidget {
  @override
  _ViewSuggestionFragment createState() => _ViewSuggestionFragment();
}

class _ViewSuggestionFragment extends State<StatefulViewSuggestionFragment> {

  @override
  Widget build(BuildContext context) {
    int id = 1; // TODO hilfe ka wie
    SuggestionManager sm = new SuggestionManager();
    Suggestion selectedSuggestion = sm.getSuggestion(id) as Suggestion;
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedSuggestion.title),
      ) ,
      body: Padding(padding: EdgeInsets.all(10) ,
        child: Column(
          children: <Widget> [
            Text("lol"),
          ],
        )
      )
    );
  }

}
