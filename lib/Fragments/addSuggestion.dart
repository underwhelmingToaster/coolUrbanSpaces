import 'package:cool_urban_spaces/api/suggestionManager.dart';
import 'package:cool_urban_spaces/controller/markerController.dart';
import 'package:cool_urban_spaces/model/suggestion.dart';
import 'package:cool_urban_spaces/main.dart';
import 'package:cool_urban_spaces/view/urbanMapView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class StatefulAddSuggestionFragment extends StatefulWidget {
  const StatefulAddSuggestionFragment({Key? key}) : super(key: key);
  @override
  _AddSuggestionFragment createState() => _AddSuggestionFragment();
}

class _AddSuggestionFragment extends State<StatefulAddSuggestionFragment> {
  final _formKey = GlobalKey<FormState>();

  String titleData = "";
  String descData = "";
  int typeData = 1;

  void submit(Suggestion suggestion){
    SuggestionManager.postSuggestion(suggestion);
    Navigator.pop(context, MaterialPageRoute(
        builder: (context) => StatefulMapFragment()));
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<MarkerController>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Suggestion"),
        backgroundColor: Color(0xff92d396
        ),
      ),
      body: Form (
        key: _formKey,
        child: Padding(padding: EdgeInsets.all(10) ,
          child: Column(
            children: <Widget> [
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Title",
                    hintText: "A short title"
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(50)],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please add a title";
                  }
                  return null;
                },
                onChanged: (value) {
                  this.titleData = value;
                }
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Description",
                    hintText: "Describe your suggestion.dart in more detail"
                ),
                inputFormatters: [LengthLimitingTextInputFormatter(500)],
                minLines: 4,
                maxLines: 10,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please describe your project";
                  }
                  return null;
                },
                onChanged: (value) {
                  this.descData = value;
                }
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Text("Type of Suggestion:")),
              DropdownButton(
                isExpanded: true,
                value: typeData,
                items: [
                  DropdownMenuItem(
                    child: Text("General"), value: 0, ),
                  DropdownMenuItem(
                    child: Text("Shading"), value: 1, ),
                  DropdownMenuItem(
                    child: Text("Seating"), value: 2, ),
                  DropdownMenuItem(
                    child: Text("Gardening"), value: 3, ),
                  DropdownMenuItem(
                    child: Text("Social"), value: 4, ),
                  DropdownMenuItem(
                    child: Text("Water"), value: 5, ),
                  DropdownMenuItem(
                    child: Text("Plants"), value: 6, ),
                ],
                onChanged: (value) {
                  setState(() { typeData = value as int; });
                }
              ),

              Padding(padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Suggestion suggestion = new Suggestion(titleData, descData, typeData,  UrbanMapView.lastLatTap, UrbanMapView.lastLngTap);
                      submit(suggestion);
                      SuggestionManager.formatSuggestions().then((value) =>
                      controller.markerList = value);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text('Submit'),
                ),
              )
            ],
          ),
        )
      )
    );
  }

}