import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StatefulAddSuggestionFragment extends StatefulWidget {
  const StatefulAddSuggestionFragment({Key? key}) : super(key: key);

  @override
  _AddSuggestionFragment createState() => _AddSuggestionFragment();
}

class _AddSuggestionFragment extends State<StatefulAddSuggestionFragment> {
  final _formKey = GlobalKey<FormState>();
  int selectedType = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a Suggestion"),
        actions: <Widget> [
          IconButton(onPressed: () { null; }, icon: Icon(Icons.add)) // TODO implement onpressed
        ],
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
              ),
              Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 20),
                child: Text("Type of Suggestion:")),
              DropdownButton(
                isExpanded: true,
                value: selectedType = 0,
                items: [
                  DropdownMenuItem(
                    child: Text("General"),
                    value: 0,
                  ),
                  DropdownMenuItem(
                    child: Text("Shading"),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text("Seating"),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text("Gardening"),
                    value: 3,
                  ),
                  DropdownMenuItem(
                    child: Text("Social"),
                    value: 4,
                  ),
                  DropdownMenuItem(
                    child: Text("Water"),
                    value: 5,
                  ),
                  DropdownMenuItem(
                    child: Text("Plants"),
                    value: 6,
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedType = value as int;
                  });
                }
              ),
              Padding(padding: EdgeInsets.all(30),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
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