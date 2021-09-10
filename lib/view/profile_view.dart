import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Provider.of<ProfileController>(context);
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Profile"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ListView(
            children: [
              Card(
                child: ListTile(
                  title: Text("Username"),
                  trailing: ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 60, maxWidth: 150),
                      child: TextFormField(
                        initialValue: profileController.username,
                        decoration: InputDecoration(
                          labelText: "Username",
                          labelStyle: new TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        inputFormatters: [LengthLimitingTextInputFormatter(500)],
                        minLines: 4,
                        maxLines: 10,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Username invalid";
                          }
                          return null;
                          },
                        onChanged: (v) => profileController.username = v,
                      ),
                  ),
                ),
              )
            ],
          ))
        ],
      ),
    ));
  }
}