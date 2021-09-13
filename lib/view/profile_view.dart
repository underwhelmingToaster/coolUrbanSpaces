import 'package:cool_urban_spaces/controller/profile_controller.dart';
import 'package:crypt/crypt.dart';
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
      body: ListView(
        children: [
          Card(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Username"),
                          TextFormField(
                            maxLength: 20,
                            onChanged: (value) {
                              profileController.username = value;
                            },
                          )
                        ],
                      )
                  )
                ],
              ),
            ),
          ),
          Card(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Password"),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                onChanged: (value) {
                                  profileController.password = value;
                                },
                              ),
                            ),
                            Text("Repeat Password"),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: TextFormField(
                                obscureText: true,
                                enableSuggestions: false,
                                autocorrect: false,
                                onChanged: (value) {
                                  profileController.scndpassword = value;
                                },
                              ),
                            ),
                          ],
                        ),
                    ),
                  ],
                ),
              ),
          ),
          ListTile(
            title: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(30),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                    ),
                    key: Key("Submit Profile-Form"),
                    onPressed: () {
                      if(profileController.submit()){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile details changed')));
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password incorrect or fields empty'), backgroundColor: Colors.red));
                      }
                    },
                    child: Text("Change Profile"),
                  ),
                )
              ],
            ),
          )
        ],
      )
    )
    );
  }
}