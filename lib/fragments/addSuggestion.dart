import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatefulAddSuggestionFragment extends StatefulWidget {
  @override
  _AddSuggestionFragment createState() => _AddSuggestionFragment();
}

class _AddSuggestionFragment extends State<StatefulAddSuggestionFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Suggestion"),
        actions: <Widget> [
          IconButton(onPressed: () { null; }, icon: Icon(Icons.add)) // TODO implement onpressed
        ],
      ),
      body: Column(
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
          ),
          TextFormField(
            decoration: InputDecoration(
                labelText: "Description",
                hintText: "Describe your suggestion in more detail"
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
          )
        ],
      ),
    );
  }

}