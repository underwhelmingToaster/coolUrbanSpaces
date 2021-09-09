import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    //MarkerController controller = Provider.of<MarkerController>(context);
    if(_id>=0){
      //TODO : get Suggestion with ID
    }
    if(_id<0){
      Navigator.pop(context);
    }

    return Visibility(
        visible: true,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              //title: controller.SelectedSuggestion != null ? Text(controller.SelectedSuggestion!.title) : Text(""),
          ),
          body: Padding(padding: EdgeInsets.all(10),
          child: Column(
          children: <Widget> [
          Text("lol"),
            ],
          )
      )
    ))
    ;
  }
}
